import 'package:flutter/material.dart';

class GenericText extends StatelessWidget {
  final String text;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextStyle? style;
  final TextDirection? textDirection;
  final Locale? locale;
  final Color? selectionColor;
  final bool? softWrap;
  final double? height;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  const GenericText(this.text,
      {Key? key,
      this.overflow,
      this.maxLines,
      this.style,
      this.textDirection,
      this.strutStyle,
      this.textWidthBasis,
      this.textScaleFactor,
      this.textHeightBehavior,
      this.textAlign,
      this.locale,
      this.height = 1,
      this.selectionColor,
      this.softWrap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      overflow: overflow,
      maxLines: maxLines,
      textDirection: textDirection,
      locale: locale,
      selectionColor: selectionColor,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor ?? 1.0,
      textWidthBasis: textWidthBasis,
    );
  }
}
