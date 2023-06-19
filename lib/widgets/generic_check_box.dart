import 'package:flutter/material.dart';

class GenericCheckBox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;

  const GenericCheckBox({this.value = false, super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
    );
  }
}
