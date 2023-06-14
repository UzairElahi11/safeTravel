import 'package:flutter/material.dart';
import 'package:safe/Utils/app_colors.dart';

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
        fillColor: AppColors.containerBgColor,

        hintText: title,
        // contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        prefixIcon: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Image.asset(
                icon,
                color: AppColors.baseColor,
              ),
            ), // Your suffix icon
            Positioned(
              top: 12, // Adjust the position as needed
              right: 0, // Adjust the position as needed
              child: Container(
                width: 1,
                height: 20,
                color: Colors.grey, // Color of the line
              ),
            ),
          ],
        ),
        filled: true,
        // fillColor: AppColors.textFieldBackGroundColor,
        border: InputBorder.none,
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),

        //   // borderSide: BorderSide(
        //   //     width: 1, color: AppColors.textFieldOutlineColor), //
        // ),
      ),
    );
  }
}
