import 'package:flutter/material.dart';

class ListHelper extends StatelessWidget {
  final Function callBack;
  final String title;
  final String img;
  const ListHelper(
      {super.key,
      required this.title,
      required this.img,
      required this.callBack});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        callBack();
      },
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      leading: Image.asset(img),
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
