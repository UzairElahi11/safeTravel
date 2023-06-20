import 'package:flutter/material.dart';

class GenericIcon extends StatelessWidget {
  final IconData icon;
  final double? fill;
  final Color? color;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadow;
  final double? size;
  final TextDirection? textDirection;
  final double? weight;
  const GenericIcon(
      {super.key,
      required this.icon,
      this.fill,
      this.color,
      this.grade,
      this.opticalSize,
      this.shadow,
      this.size,
      this.textDirection,
      this.weight});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: color,
      fill: fill,
      grade: grade,
      opticalSize: opticalSize,
      shadows: shadow,
      size: size,
      textDirection: textDirection,
      weight: weight,
    );
  }
}
