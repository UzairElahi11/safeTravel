import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String title;
  final String icon;
  final TextEditingController controllerText;
  final bool isHidden;
  const TextFieldCustom(
      {super.key,
      required this.title,
      required this.icon,
      this.isHidden = false,
      required this.controllerText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerText,
      obscureText: isHidden,
      decoration: InputDecoration(
        label: Text(title),
        prefixIcon: Image.asset(icon),
        filled: true,
        // fillColor: AppColors.textFieldBackGroundColor,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),

          // borderSide: BorderSide(
          //     width: 1, color: AppColors.textFieldOutlineColor), //
        ),
      ),
    );
  }
}
