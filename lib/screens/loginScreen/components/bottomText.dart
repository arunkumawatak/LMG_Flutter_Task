import 'package:flutter/material.dart';
import 'package:lmg_flutter_task/screens/loginScreen/animations/change_screen_animation.dart';
import 'package:lmg_flutter_task/utils/colors.dart';
import 'package:lmg_flutter_task/utils/commonWidgets.dart';
import 'package:lmg_flutter_task/utils/helperFunctions.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';
import 'loginContent.dart';

class BottomText extends StatefulWidget {
  const BottomText({Key? key}) : super(key: key);

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    ChangeScreenAnimation.bottomTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.bottomTextAnimation,
      child: GestureDetector(
        onTap: () {
          if (!ChangeScreenAnimation.isPlaying) {
            ChangeScreenAnimation.currentScreen == Screens.createAccount
                ? ChangeScreenAnimation.forward()
                : ChangeScreenAnimation.reverse();

            ChangeScreenAnimation.currentScreen =
                Screens.values[1 - ChangeScreenAnimation.currentScreen.index];
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RichText(
            text: TextSpan(
              style: commonTextStyle(
                fontSize: 16,
              ),
              children: [
                TextSpan(
                  text: ChangeScreenAnimation.currentScreen ==
                          Screens.createAccount
                      ? StringConst.alreadyHaveAccount
                      : StringConst.dontHaveAccount,
                  style: commonTextStyle(
                    color: ColorConst.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ChangeScreenAnimation.currentScreen ==
                          Screens.createAccount
                      ? StringConst.login
                      : StringConst.signUp,
                  style: commonTextStyle(
                    color: ColorConst.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
