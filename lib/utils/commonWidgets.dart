import 'package:flutter/material.dart';
import 'package:lmg_flutter_task/utils/colors.dart';

TextStyle commonTextStyle({
  double fontSize = 14.0,
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.black,
}) {
  return TextStyle(
    fontFamily: 'Montserrat',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}

InputDecoration textFieldDecoration({
  String? hint,
  Widget? suffixIcon,
  Color? fillColor,
}) {
  return InputDecoration(
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.all(12),
    filled: true,
    hintStyle: commonTextStyle(color: Colors.black54),
    fillColor: fillColor ?? ColorConst.commonShadowColor.withAlpha(100),
    counterText: '',
    hintText: hint ?? '',
    errorStyle: commonTextStyle(color: Colors.red),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ColorConst.primaryColor, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ColorConst.primaryColor, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(10)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(10)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: ColorConst.primaryColor, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(10)),
  );
}

BoxDecoration commonBoxDecoration(
    {Color? color,
    BorderRadius? borderRadius,
    double? borderWidth,
    Color? borderColor,
    bool? shadow,
    Color? shadowColor,
    double? spreadRadius}) {
  return BoxDecoration(
    color: color ?? ColorConst.primaryColor,
    borderRadius: borderRadius ?? BorderRadius.circular(25),
    border: Border.all(
        width: borderWidth == true ? 1 : 0,
        color: borderColor ?? Colors.transparent),
    boxShadow: [
      if (shadow == true)
        BoxShadow(
          color: shadowColor ?? ColorConst.commonShadowColor,
          blurRadius: 8.0, // soften the shadow
          spreadRadius: spreadRadius ?? 1.0, //extend the shadow
        )
    ],
  );
}
