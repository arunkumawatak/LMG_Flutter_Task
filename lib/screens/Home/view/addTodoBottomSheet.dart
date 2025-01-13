import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/Home/Controller/homeController.dart';
import 'package:lmg_flutter_task/utils/appValidator.dart';
import 'package:lmg_flutter_task/utils/colorConst.dart';
import 'package:lmg_flutter_task/utils/widgets/commonWidgets.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';

class AddTodoBottomSheet extends StatelessWidget {
  final HomeController controller = Get.find();
  final int? todoId;

  AddTodoBottomSheet({this.todoId});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    if (todoId != null) {
      final todo = controller.todos.firstWhere((t) => t.id == todoId);
      controller.titleController.text = todo.title;
      controller.descriptionController.text = todo.description;
      controller.timeController.text = (todo.time! ~/ 60).toString();
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: ColorConst.backGroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
// Title TextFormField
              const SizedBox(height: 10),
              TextFormField(
                  validator: (value) => AppValidator.fieldRequired(value,
                      fieldName: StringConst.title),
                  controller: controller.titleController,
                  decoration: textFieldDecoration(
                      hint: StringConst.title, fillColor: Colors.white)),
              const SizedBox(height: 10),

              // Description TextFormField
              TextFormField(
                validator: (value) => AppValidator.fieldRequired(value,
                    fieldName: StringConst.description),
                controller: controller.descriptionController,
                decoration: textFieldDecoration(
                    hint: StringConst.description, fillColor: Colors.white),
              ),
              const SizedBox(height: 10),

              // Time TextFormField
              TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) => AppValidator.fieldRequired(value,
                      fieldName: StringConst.time),
                  controller: controller.timeController,
                  decoration: textFieldDecoration(
                      hint: StringConst.timesInMin, fillColor: Colors.white)),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: commonButton(
                      context: context,
                      title: StringConst.cancel,
                      onTap: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: commonButton(
                      color: ColorConst.iconColor,
                      context: context,
                      title: StringConst.add,
                      onTap: () {
                        final title = controller.titleController.text.trim();
                        final description =
                            controller.descriptionController.text.trim();
                        final time = int.tryParse(
                                controller.timeController.text.trim()) ??
                            0;
                        if (formKey.currentState!.validate()) {
                          if (time <= 0 || time > 5) {
                            Get.snackbar(
                                StringConst.error, StringConst.timerError);
                            return;
                          } else {
                            if (todoId != null) {
                              controller.updateTodo(
                                todoId!,
                                title,
                                description,
                                time * 60,
                                0,
                              );
                            } else {
                              controller.addTodo(
                                title,
                                description,
                                time * 60,
                              );
                            }
                            controller.titleController.clear();
                            controller.descriptionController.clear();
                            controller.timeController.clear();
                            Get.back();
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
