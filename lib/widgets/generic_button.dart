import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';

import 'generic_text.dart';

class GenericButton extends StatelessWidget {
  final double? width, height, radius, textSize;
  final Color? color, textColor;
  final EdgeInsets? margin, padding;
  final VoidCallback onPressed;
  final String? text;
  final Widget? child;
  final bool enableMarquee;
  final TextStyle? textStyle;
  final double? borderRadius;
  final Color? borderColor;
  final Widget? leading;
  final double? borderWidth;

  const GenericButton(
      {Key? key,
      this.text,
      required this.onPressed,
      this.height,
      this.width,
      this.textSize,
      this.color,
      this.textColor,
      this.radius,
      this.margin,
      this.padding,
      this.borderColor,
      this.textStyle,
      this.borderRadius,
      this.leading,
      this.child,
      this.enableMarquee = false,
      this.borderWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 0),
        width: width ?? 338.w,
        height: height ?? 52.h,
        decoration: BoxDecoration(
            border: Border.all(
                color: borderColor ?? color ?? AppColors.baseColor,
                width: borderWidth ?? 1.0),
            borderRadius: BorderRadius.circular(borderRadius ?? 18),
            color: color ?? AppColors.baseColor),
        child: Center(
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
            child: child ??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    leading ?? Container(),
                    SizedBox(
                      width: leading != null ? 10.w : 0,
                    ),
                    Expanded(
                      child: GenericText(
                        text ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: textStyle,
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
