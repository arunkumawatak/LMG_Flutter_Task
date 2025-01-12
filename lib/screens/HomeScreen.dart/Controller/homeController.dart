import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/HomeScreen.dart/model/todoModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Homecontroller extends GetxController {
  late Database _db;
  var todos = <TodoModel>[].obs;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
          'CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
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

  Future<void> addTodo(String title, String description) async {
    await _db.insert('todos', {
      'title': title,
      'description': description,
    });
    fetchTodos();
  }

  Future<void> updateTodo(int id, String title, String description) async {
    await _db.update(
      'todos',
      {
        'title': title,
        'description': description,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchTodos();
  }

  Future<void> deleteTodo(int id) async {
    await _db.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchTodos();
  }
}
