import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:lmg_flutter_task/main.dart';
import 'package:lmg_flutter_task/screens/HomeScreen.dart/homeScreen.dart';
import 'package:lmg_flutter_task/utils/colors.dart';
import 'package:lmg_flutter_task/utils/commonWidgets.dart';
import 'package:lmg_flutter_task/utils/helperFunctions.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';
import '../animations/change_screen_animation.dart';
import 'bottomText.dart';
import 'topText.dart';

enum Screens {
  createAccount,
  welcomeBack,
}

class LoginContent extends StatefulWidget {
  const LoginContent({Key? key}) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  late final List<Widget> createAccountContent;
  late final List<Widget> loginContent;

  Widget inputField(String hint, IconData iconData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              prefixIcon: Icon(
                iconData,
                color: ColorConst.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          backgroundColor: ColorConst.primaryColor,
          shape: const StadiumBorder(),
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: commonTextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextButton(
        onPressed: () {},
        child: Text(
          StringConst.forgetPassword,
          style: commonTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ColorConst.secondaryColor,
          ),
        ),
      ),
    );
  }

  Widget spacer({double? height, double? width}) {
    return SizedBox(
      height: height ?? 10,
      width: width ?? 10,
    );
  }

  @override
  void initState() {
    createAccountContent = [
      inputField('Name', Icons.person_outline),
      inputField('Email', Icons.mail_outline),
      inputField('Password', Icons.lock),
      loginButton(
          title: 'Sign Up',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }),
      spacer(height: 50, width: 0)
    ];

    loginContent = [
      inputField('Email', Icons.mail),
      inputField('Password', Icons.lock),
      loginButton(
          title: 'Log In',
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
            );
          }),
      forgotPassword(),
      spacer(height: 50, width: 0)
    ];

    ChangeScreenAnimation.initialize(
      vsync: this,
      createAccountItems: createAccountContent.length,
      loginItems: loginContent.length,
    );

    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.createAccountAnimations[i],
        child: createAccountContent[i],
      );
    }

    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
        animation: ChangeScreenAnimation.loginAnimations[i],
        child: loginContent[i],
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    ChangeScreenAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned(
          top: 136,
          left: 24,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: createAccountContent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: loginContent,
              ),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}



// todo background color
// 121212 


  // Widget orDivider() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
  //     child: Row(
  //       children: [
  //         Flexible(
  //           child: Container(
  //             height: 1,
  //             color: ColorConst.primaryColor,
  //           ),
  //         ),
  //         const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16),
  //           child: Text(
  //             'or',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //         Flexible(
  //           child: Container(
  //             height: 1,
  //             color: ColorConst.primaryColor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget logos() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Image.asset('assets/images/facebook.png'),
  //         const SizedBox(width: 24),
  //         Image.asset('assets/images/google.png'),
  //       ],
  //     ),
  //   );
  // }
  // Widget orDivider() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
  //     child: Row(
  //       children: [
  //         Flexible(
  //           child: Container(
  //             height: 1,
  //             color: ColorConst.primaryColor,
  //           ),
  //         ),
  //         const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 16),
  //           child: Text(
  //             'or',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //         Flexible(
  //           child: Container(
  //             height: 1,
  //             color: ColorConst.primaryColor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget logos() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 16),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Image.asset('assets/images/facebook.png'),
  //         const SizedBox(width: 24),
  //         Image.asset('assets/images/google.png'),
  //       ],
  //     ),
  //   );
  // }
