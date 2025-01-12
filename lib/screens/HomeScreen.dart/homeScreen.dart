import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/HomeScreen.dart/Controller/homeController.dart';
import 'package:lmg_flutter_task/screens/HomeScreen.dart/model/todoModel.dart';
import 'package:lmg_flutter_task/utils/appValidator.dart';
import 'package:lmg_flutter_task/utils/colors.dart';
import 'package:lmg_flutter_task/utils/commonWidgets.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Homecontroller controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConst.iconColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          StringConst.todo,
          style: commonTextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: controller.todos.length,
              itemBuilder: (context, index) {
                final todo = controller.todos[index];
                return Card(
                  elevation: 0.2,
                  color: ColorConst.cardColor,
                  child: ListTile(
                    title: Text(
                      todo.title,
                      style: commonTextStyle(
                          color: ColorConst.primaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: commonTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: ColorConst.primaryTextColor,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: ColorConst.primaryTextColor,
                          ),
                          onPressed: () => _showEditDialog(context, todo),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () => controller.deleteTodo(todo.id!),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConst.iconColor,
        onPressed: () => addTodoBottomSheet(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, TodoModel todo) {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);
    Get.dialog(
      AlertDialog(
        title: Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              StringConst.cancel,
              style: commonTextStyle(),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.updateTodo(
                todo.id!,
                titleController.text,
                descriptionController.text,
              );
              Get.back();
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  addTodoBottomSheet(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: ColorConst.iconColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          StringConst.addTodo,
                          style: commonTextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.descriptionController.clear();
                            controller.titleController.clear();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Title TextFormField
                    TextFormField(
                      validator: (value) => AppValidator.fieldRequired(value,
                          fieldName: StringConst.title),
                      controller: controller.titleController,
                      decoration: textFieldDecoration(
                        fillColor: Colors.white,
                        hint: StringConst.title,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Description TextFormField
                    TextFormField(
                      validator: (value) => AppValidator.fieldRequired(
                          value?.trim(),
                          fieldName: StringConst.description),
                      controller: controller.descriptionController,
                      decoration: textFieldDecoration(
                        fillColor: Colors.white,
                        hint: StringConst.description,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Add Button
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.addTodo(
                            controller.titleController.text,
                            controller.descriptionController.text,
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: commonBoxDecoration(),
                        child: Text(
                          StringConst.add,
                          style: commonTextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
