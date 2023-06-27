// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:safe/Utils/generics/generic_text.dart';

class MyDialog extends StatelessWidget {
  final Function cancelCallBack;
  final Function proceedCallBack;

  const MyDialog(
      {super.key, required this.cancelCallBack, required this.proceedCallBack});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const GenericText(
        'Add Another Person',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: const GenericText(
        'To add another person, you need to fill the form for that person. Thanks!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            cancelCallBack();
          },
          child: const GenericText('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            proceedCallBack();
          },
          child: const GenericText('Proceed'),
        ),
      ],
    );
  }
}
