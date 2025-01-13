import 'package:flutter/material.dart';
import 'package:lmg_flutter_task/utils/colorConst.dart';

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

//common button
Widget commonButton(
    {required BuildContext context,
    required String title,
    VoidCallback? onTap,
    double? height,
    double? width,
    Color? color}) {
  return InkWell(
    onTap: onTap ?? () {},
    child: Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 40,
      alignment: Alignment.center,
      decoration: commonBoxDecoration(color: color),
      child: Text(
        title,
        style:
            commonTextStyle(fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ),
  );
}

//common text field

commonTextFied(
    {required hint,
    required controller,
    required iconData,
    required validator}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
    child: SizedBox(
      height: 50,
      child: Material(
        elevation: 8,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        child: TextFormField(
          validator: validator,
          controller: controller,
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

Widget loginButton(
    {required String title,
    required VoidCallback onTap,
    bool isLoading = false}) {
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
      child: isLoading
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : Text(
              title,
              style: commonTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
    ),
  );
}
