import 'package:flutter/material.dart';

class IntroViewModel with ChangeNotifier {
  bool isHidden = false;
  bool checkBox = false;

  void init() {}

  checkBoxHandler(bool check) {
    checkBox = check;
    notifyListeners();
  }
}
