import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/Auth/controller/authController.dart';
import 'package:lmg_flutter_task/screens/Auth/view/loginScreen.dart';
import 'package:lmg_flutter_task/screens/Home/Controller/homeController.dart';
import 'package:lmg_flutter_task/screens/Home/view/addTodoBottomSheet.dart';
import 'package:lmg_flutter_task/screens/Home/view/todoDetailScreen.dart';
import 'package:lmg_flutter_task/utils/colorConst.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';
import 'package:lmg_flutter_task/utils/widgets/commonWidgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  final AuthController authController = AuthController();
  @override
  void dispose() {
    Get.delete<HomeController>();
    Get.delete<AuthController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConst.backGroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          StringConst.todo,
          style: commonTextStyle(
              color: ColorConst.primaryTextColor,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
//logOut
        actions: [
          IconButton(
              onPressed: () async {
                await authController.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.searchQuery.value = value,
                decoration: InputDecoration(
                  hintText: StringConst.searchTodos,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Obx(() {
                final todos = controller.filteredTodos;
                if (todos.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/noDataFoundImg.png",
                        // height: 300,
                      ),
                      Text(
                        StringConst.noDataFound,
                        style: commonTextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.builder(
                    itemCount: todos.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Card(
                        elevation: 0.5,
                        color: const Color.fromARGB(255, 239, 255, 251),
                        child: ListTile(
                          title: Text(
                            todo.title,
                            style: commonTextStyle(
                                color: ColorConst.primaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            "Status: ${[
                              "TODO",
                              "In-Progress",
                              "Done"
                            ][todo.status!]} \n"
                            "Timer: ${controller.getFormattedTime(todo.time)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: todo.status == 2
                                  ? Colors.green // Green for "Done"
                                  : Colors.black, // Default for other statuses
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => controller.deleteTodo(todo.id!),
                          ),
                          onTap: () =>
                              Get.to(() => TodoDetailScreen(todo: todo)),
                        ),
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConst.iconColor,
        onPressed: () => Get.bottomSheet(AddTodoBottomSheet()),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
