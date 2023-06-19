import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/typedef.dart';

class GenericTextField extends StatelessWidget {
  final Color? borderColor,
      focusedBorder,
      fillColor,
      requiredSpanColor,
      labelColor,
      textColor,
      hintColor;
  final TextStyle? hintStyle, textStyle;
  final String? hintText, errorText;
  final Widget? leadingIcon, trailingIcon;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool? isObscure, enableSuggestion, autoCorrection, filled;
  final InputDecoration? decoration;
  final bool isRequired;
  final bool isNumberField;
  final TextEditingController controller;
  final Function(String)? onFieldSubmit;
  final double? borderRadius;
  final int? maxLength;
  final bool? enable;
  final GenericTextFieldValidator? validator;
  final bool useUnderLinedInputBorder;
  final bool useZeroPrefixPadding;
  final EdgeInsetsGeometry? prefixPadding;
  final EdgeInsetsGeometry? trailingPadding;
  final List<TextInputFormatter> inputFormatters;
  final int? errorMaxLines;
  final TextAlign textAlign;
  final double? spaceBetweenLabelAndField;
  final Function(dynamic value)? onChange;

  const GenericTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.borderColor,
    this.prefixPadding,
    this.isObscure,
    this.labelColor,
    this.textColor,
    this.hintColor,
    this.onChange,
    this.focusNode,
    this.leadingIcon,
    this.maxLines,
    this.textInputType,
    this.useUnderLinedInputBorder = false,
    this.requiredSpanColor,
    this.isRequired = false,
    this.textInputAction,
    this.hintStyle,
    this.textStyle,
    this.decoration,
    this.validator,
    this.fillColor,
    this.filled,
    this.spaceBetweenLabelAndField,
    this.contentPadding,
    this.focusedBorder,
    this.enableSuggestion,
    this.autoCorrection,
    this.errorText,
    this.errorMaxLines,
    this.trailingIcon,
    this.isNumberField = false,
    this.useZeroPrefixPadding = false,
    this.borderRadius,
    this.maxLength,
    this.enable,
    this.onFieldSubmit,
    this.inputFormatters = const [],
    this.textAlign = TextAlign.start,
    this.trailingPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure ?? false,
      maxLines: maxLines ?? 1,
      enabled: enable ?? true,
      maxLength: maxLength,
      textAlign: textAlign,
      onChanged: onChange,
      validator: validator,
      style: textStyle,
      enableSuggestions: enableSuggestion ?? true,
      keyboardType: isNumberField ? TextInputType.phone : textInputType,
      autocorrect: autoCorrection ?? true,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmit,
      decoration: decoration ??
          InputDecoration(
            counterText: "",
            contentPadding: contentPadding ??
                ((maxLines == null)
                    ? EdgeInsets.symmetric(horizontal: 5.w)
                    : EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h)),
            hintText: hintText ?? '',
            hintMaxLines: 1,
            filled: filled,
            fillColor: fillColor,
            hintStyle: hintStyle,
            errorText: errorText,
            errorMaxLines: errorMaxLines,
            border: useUnderLinedInputBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: borderColor ?? fillColor ?? Colors.transparent,
                  ))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? fillColor ?? Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
                  ),
            enabledBorder: useUnderLinedInputBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: borderColor ?? fillColor ?? Colors.transparent,
                  ))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor ?? fillColor ?? Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
                  ),
            focusedBorder: useUnderLinedInputBorder
                ? UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: borderColor ?? fillColor ?? Colors.transparent,
                  ))
                : OutlineInputBorder(
                    borderSide: BorderSide(
                      color: focusedBorder ??
                          fillColor ??
                          borderColor ??
                          Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
                  ),
            suffixIcon: trailingIcon != null
                ? Padding(
                    padding: trailingPadding ??
                        EdgeInsetsDirectional.only(end: 10.w, start: 5.w),
                    child: trailingIcon,
                  )
                : null,
            prefixIcon: Padding(
              padding: prefixPadding ??
                  EdgeInsetsDirectional.only(
                    start: useZeroPrefixPadding ? 0.w : 10.w,
                    end: 5.w,
                  ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    SizedBox(
                      width: 5.w,
                    ),
                  ],
                ],
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              minHeight: 0.h,
              minWidth: 0.h,
            ),
            suffixIconConstraints: BoxConstraints(
              minHeight: 0.h,
              minWidth: 0.h,
            ),
          ),
      inputFormatters: inputFormatters,
    );
  }
}
