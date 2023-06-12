
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:safe/Utils/pawa_color.dart';


class ContainerWithSocialMediaIcons extends StatelessWidget {
  final String imgPath1;
  final String imgPath2;
  final String imgPath3;
  final VoidCallback? googleOnPress;
  final VoidCallback? facebookOnPress;

  final VoidCallback? appleOnPress;

  const ContainerWithSocialMediaIcons(
      {super.key,
      required this.imgPath1,
      required this.imgPath2,
      required this.imgPath3,
      this.googleOnPress,
      this.facebookOnPress,
      this.appleOnPress});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: facebookOnPress,
          child: Container(
            height: 57,
            width: 71,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: PawaColor.themeColor(context).textFieldOutlineColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(imgPath1)),
          ),
        ),
      const  SizedBox(width: 20,),
        GestureDetector(
          onTap: googleOnPress,
          child: Container(
            height: 57,
            width: 71,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: PawaColor.themeColor(context).textFieldOutlineColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(child: Image.asset(imgPath2)),
          ),
        ),
      Platform.isIOS?  const  SizedBox(width: 20,):const SizedBox(),
        Platform.isIOS?
        GestureDetector(
          onTap: appleOnPress,
          child: Container(
            height: 57,
            width: 71,
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: PawaColor.themeColor(context).textFieldOutlineColor),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(child: Image.asset(imgPath3)),
          ),
        ):const SizedBox()
      ],
    );
  }
}
