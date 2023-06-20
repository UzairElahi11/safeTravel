import 'package:flutter/material.dart';
import 'package:safe/Utils/app_colors.dart';

class GenericCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final bool? autoFocus;
  final Color? activeColor;
  final Color? checkColor;
  final Color? focusColor;
  final OutlinedBorder? shape;
  final MaterialStateProperty<Color?>? fillColor;
  final FocusNode? focusnode;
  final Color? hoverColor;
  final bool isError;
  final Key? checkBoxKey;
  final MaterialTapTargetSize? materialTapTargetSize;
  final MaterialStateProperty<Color?>? overlayColor;
  final BorderSide? borderSide;
  final double? splashRadius;
  final bool? tristate;
  final VisualDensity? visualDensity;

  const GenericCheckBox(
      {this.value = false,
      super.key,
      this.onChanged,
      this.activeColor,
      this.autoFocus,
      this.checkColor,
      this.focusColor,
      this.shape,
      this.fillColor,
      this.focusnode,
      this.hoverColor,
      this.isError = false,
      this.checkBoxKey,
      this.materialTapTargetSize,
      this.overlayColor,
      this.borderSide,
      this.splashRadius,
      this.tristate,
      this.visualDensity});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      key: checkBoxKey,
      activeColor: activeColor ?? AppColors.redColor,
      autofocus: autoFocus ?? false,
      value: value,
      onChanged: onChanged,
      checkColor: checkColor ?? AppColors.whiteColor,
      focusColor: focusColor,
      shape: shape,
      fillColor: fillColor ?? MaterialStateProperty.all(AppColors.baseColor),
      focusNode: focusnode,
      hoverColor: hoverColor,
      isError: isError,
      materialTapTargetSize: materialTapTargetSize,
      overlayColor: overlayColor,
      side: borderSide ??
          BorderSide(
            width: 5,
            color: AppColors.whiteColor,
          ),
      splashRadius: splashRadius,
      tristate: tristate ?? false,
      visualDensity: visualDensity,
    );
  }
}
