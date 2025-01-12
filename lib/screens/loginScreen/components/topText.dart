import 'package:flutter/material.dart';
import 'package:lmg_flutter_task/screens/loginScreen/animations/change_screen_animation.dart';
import 'package:lmg_flutter_task/utils/commonWidgets.dart';
import 'package:lmg_flutter_task/utils/helperFunctions.dart';
import 'loginContent.dart';

class TopText extends StatefulWidget {
  const TopText({Key? key}) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimation.topTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.topTextAnimation,
      child: Text(
        ChangeScreenAnimation.currentScreen == Screens.createAccount
            ? 'Create\nAccount'
            : 'Welcome\nBack',
        style: commonTextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
