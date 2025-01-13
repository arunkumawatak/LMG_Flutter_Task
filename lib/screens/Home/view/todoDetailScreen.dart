import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/Home/Controller/homeController.dart';
import 'package:lmg_flutter_task/screens/Home/Model/todoModel.dart';
import 'package:lmg_flutter_task/screens/Home/view/addTodoBottomSheet.dart';
import 'package:lmg_flutter_task/utils/colorConst.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';
import 'package:lmg_flutter_task/utils/widgets/commonWidgets.dart';

class TodoDetailScreen extends StatelessWidget {
  final TodoModel todo;
  final HomeController controller = Get.find();

  TodoDetailScreen({required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConst.primaryTextColor),
        title: Text(
          StringConst.todoDetails,
          style: commonTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: ColorConst.primaryTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: ColorConst.primaryTextColor,
              ),
              onPressed: () =>
                  Get.bottomSheet(AddTodoBottomSheet(todoId: todo.id)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final currentTodo =
              controller.todos.firstWhere((t) => t.id == todo.id);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title: ${currentTodo.title}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Description: ${currentTodo.description}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Status: ${[
                  "TODO",
                  "In-Progress",
                  "Done"
                ][currentTodo.status!]}",
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                "Timer: ${controller.getFormattedTime(currentTodo.time)}",
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: commonButton(
                    context: context,
                    title: StringConst.start,
                    onTap: currentTodo.status == 1
                        ? null
                        : () => controller.startTimer(currentTodo),
                  )),
                  const SizedBox(width: 20),
                  Expanded(
                      child: commonButton(
                    context: context,
                    color: Colors.red,
                    title: StringConst.complete,
                    onTap: () {
                      controller.stopTimer();
                      controller.updateTodo(
                        currentTodo.id!,
                        currentTodo.title,
                        currentTodo.description,
                        0,
                        2, // Mark as Done
                      );
                    },
                  )),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
