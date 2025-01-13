import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/Auth/controller/authController.dart';
import 'package:lmg_flutter_task/screens/Home/view/homeScreen.dart';
import 'package:lmg_flutter_task/utils/appValidator.dart';
import 'package:lmg_flutter_task/utils/colorConst.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';
import 'package:lmg_flutter_task/utils/widgets/commonWidgets.dart';

class Logincontent extends StatefulWidget {
  final int screenType;
  final ValueChanged<int> onScreenTypeChange;

  const Logincontent({
    super.key,
    required this.screenType,
    required this.onScreenTypeChange,
  });

  @override
  State<Logincontent> createState() => _LogincontentState();
}

class _LogincontentState extends State<Logincontent> {
  final controller = Get.put(AuthController());
  final formKey = GlobalKey<FormState>();
  // @override
  // void dispose() {
  //   Get.delete<AuthController>();
  //   super.dispose();
  // }

  void switchScreenType() {
    widget.onScreenTypeChange(widget.screenType == 1 ? 0 : 1);
    controller.emailController.clear();
    controller.passController.clear();
    controller.nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 136,
          left: 24,
          child: Text(
            widget.screenType == 1
                ? StringConst.createAccount
                : StringConst.welcomeBack,
            style: commonTextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.screenType == 1)
                  commonTextFied(
                    hint: StringConst.name,
                    controller: controller.nameController,
                    iconData: Icons.person,
                    validator: (value) => AppValidator.fieldRequired(
                      value,
                      fieldName: StringConst.name,
                    ),
                  ),
                commonTextFied(
                  hint: StringConst.email,
                  controller: controller.emailController,
                  iconData: Icons.mail_outline,
                  validator: (value) => AppValidator.fieldRequired(
                    value,
                    fieldName: StringConst.email,
                  ),
                ),
                commonTextFied(
                  hint: StringConst.password,
                  controller: controller.passController,
                  iconData: Icons.password_sharp,
                  validator: (value) =>
                      validatePassword(controller.passController.text.trim()),
                ),
                Obx(() {
                  return loginButton(
                    isLoading: widget.screenType == 1
                        ? controller.isSignUpLoading.value
                        : controller.isLoginLoading.value,
                    title: widget.screenType == 1
                        ? StringConst.signUp
                        : StringConst.login,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if (widget.screenType == 1) {
                          final user = await controller.createUser(
                            controller.emailController.text.trim(),
                            controller.passController.text.trim(),
                          );
                          if (user != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          }
                        } else {
                          final user = await controller.loginWithEmail(
                            controller.emailController.text.trim(),
                            controller.passController.text.trim(),
                          );
                          if (user != null) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          }
                        }
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.screenType == 1
                      ? StringConst.alreadyHaveAccount
                      : StringConst.dontHaveAccount,
                  style: commonTextStyle(
                    color: ColorConst.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: switchScreenType,
                  child: Text(
                    widget.screenType == 1
                        ? StringConst.login
                        : StringConst.signUp,
                    style: commonTextStyle(
                      color: ColorConst.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
