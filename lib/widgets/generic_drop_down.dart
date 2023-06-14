import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/widgets/generic_svg_image.dart';

import '../constants/typedef.dart';
import 'generic_asset_image.dart';

class GenericDropDown<T> extends StatelessWidget {
  final OnDropDownItemChanged<T?> onDropDownItemChanged;
  final MapDropDownText<T> mapDropDownText;
  final List<T> items;
  final T? value;
  final Widget? icon;
  final Color? iconColor;
  final Color? dropDownColor;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? hintColor;
  final bool useTransparentBorder;
  final InputDecoration? decoration;
  final EdgeInsets? contentPadding;
  final bool filled;
  final Color? fillColor;
  final Widget? leading;
  final Color? dropdownPopupBgColor;
  final double? paddingBetweenLabelAndDropdown;
  final AlignmentGeometry? alignment;
  final DropdownValidator<T>? validator;
  final Color? borderColor;

  const GenericDropDown({
    Key? key,
    this.borderColor,
    required this.items,
    required this.mapDropDownText,
    required this.onDropDownItemChanged,
    this.contentPadding,
    this.value,
    this.dropDownColor,
    this.hintText,
    this.hintTextStyle,
    this.textStyle,
    this.textColor,
    this.leading,
    this.hintColor,
    this.dropdownPopupBgColor,
    this.paddingBetweenLabelAndDropdown,
    this.fillColor,
    this.alignment,
    this.validator,
    this.filled = true,
    this.useTransparentBorder = false,
    this.icon,
    this.iconColor,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        isDense: false,
        autovalidateMode: AutovalidateMode.always,
        hint: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            hintText ?? "",
            style: hintTextStyle,
          ),
        ),
        validator: validator,
        dropdownColor: dropDownColor,
        style: textStyle,
        decoration: useTransparentBorder
            ? InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent)),
                prefixIcon: leading,
                filled: filled,
                fillColor: fillColor,
                contentPadding: contentPadding ??
                    (!filled
                        ? EdgeInsets.zero
                        : (leading != null)
                            ? EdgeInsetsDirectional.only(end: 20.w)
                            : EdgeInsetsDirectional.only(
                                end: 20.w, start: 8.w)))
            : decoration ??
                InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: fillColor ?? Colors.white),
                    ),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    prefixIcon: leading,
                    filled: filled,
                    fillColor: fillColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: fillColor ?? Colors.white,
                      ),
                    ),
                    contentPadding: contentPadding ??
                        (!filled
                            ? EdgeInsets.zero
                            : (leading != null)
                                ? EdgeInsetsDirectional.only(end: 20.w)
                                : EdgeInsetsDirectional.only(
                                    end: 20.w, start: 8.w))),
        alignment: alignment ?? AlignmentDirectional.centerStart,
        value: (value != null)
            ? value
            : (hintText == null)
                ? (items.isEmpty)
                    ? null
                    : items.first
                : null,
        items: items
            .map((e) => DropdownMenuItem<T>(
                  value: e,
                  child: mapDropDownText(e),
                ))
            .toList(),
        onChanged: (value) {
          onDropDownItemChanged(value);
        },
        icon: icon ??
            GenericSvgImage(
              svgPath: AppImages.dropDownSvgIcon,
            ),
      ),
    ));
  }
}
