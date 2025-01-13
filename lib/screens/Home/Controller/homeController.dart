import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/Home/Model/todoModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  late Database _db;
  var todos = <TodoModel>[].obs;
  var searchQuery = ''.obs;
  Timer? _timer;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _initDb();
  }

  Future<void> _initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, status INTEGER, time INTEGER)',
        );
      },
      version: 1,
    );
    fetchTodos();
  }

  Future<void> fetchTodos() async {
    final List<Map<String, dynamic>> maps = await _db.query('todos');
    todos.value = List.generate(maps.length, (i) => TodoModel.fromMap(maps[i]));
  }

  Future<void> addTodo(String title, String description, int time) async {
    await _db.insert(
      'todos',
      {
        'title': title,
        'description': description,
        'status': 0, // Default: TODO
        'time': time, // Time in seconds
      },
    );
    fetchTodos();
  }

  Future<void> updateTodo(
      int id, String title, String description, int time, int status) async {
    await _db.update(
      'todos',
      {
        'title': title,
        'description': description,
        'time': time,
        'status': status,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchTodos();
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  int? _currentTimerTodoId;
  void startTimer(TodoModel todo) {
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _currentTimerTodoId = todo.id; // Track the current timer's todo ID
      todos[index].status = 1; // Set status to In-Progress
      updateTodo(
        todos[index].id!,
        todos[index].title,
        todos[index].description,
        todos[index].time!,
        todos[index].status!,
      );

      _timer?.cancel(); // Ensure only one timer runs
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        // Check if the todo still exists and index is valid
        final currentIndex =
            todos.indexWhere((t) => t.id == _currentTimerTodoId);
        if (currentIndex == -1) {
          timer.cancel(); // Stop the timer if the todo was deleted
          return;
        }

        if (todos[currentIndex].time! > 0) {
          todos[currentIndex].time = todos[currentIndex].time! - 1;
          updateTodo(
            todos[currentIndex].id!,
            todos[currentIndex].title,
            todos[currentIndex].description,
            todos[currentIndex].time!,
            todos[currentIndex].status!,
          );
        } else {
          todos[currentIndex].status = 2; // Set status to Done
          updateTodo(
            todos[currentIndex].id!,
            todos[currentIndex].title,
            todos[currentIndex].description,
            todos[currentIndex].time!,
            todos[currentIndex].status!,
          );
          timer.cancel();
          _currentTimerTodoId = null; // Clear the current timer ID
          fetchTodos(); // Refresh UI
        }
      });
    }
  }

  Future<void> deleteTodo(int id) async {
    if (_currentTimerTodoId == id) {
      stopTimer();
    }

    await _db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchTodos();
  }

  String getFormattedTime(int? time) {
    if (time == null || time <= 0) return "00:00";
    final minutes = (time ~/ 60).toString().padLeft(2, '0');
    final seconds = (time % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  List<TodoModel> get filteredTodos {
    if (searchQuery.value.isEmpty) {
      return todos;
    } else {
      return todos
          .where((todo) => todo.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }
}
