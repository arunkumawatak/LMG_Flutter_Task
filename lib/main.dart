import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lmg_flutter_task/screens/Auth/view/loginScreen.dart';
import 'package:lmg_flutter_task/utils/colorConst.dart';
import 'package:lmg_flutter_task/utils/stringConst.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringConst.appName,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
      theme: ThemeData.from(
              colorScheme:
                  const ColorScheme.light(primary: ColorConst.primaryColor))
          .copyWith(
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: ColorConst.primaryColor, fontFamily: 'Montserrat'),
        appBarTheme:
            const AppBarTheme(backgroundColor: ColorConst.backGroundColor),
        scaffoldBackgroundColor: ColorConst.backGroundColor,
      ),
      home: const LoginScreen(),
    );
  }
}
