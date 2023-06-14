import 'package:flutter/material.dart';

class RegistrationViewModel with ChangeNotifier {
  bool isHidden = false;
  bool checkBox = false;
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  void init() {}

  checkBoxHandler(bool check) {
    checkBox = check;
    notifyListeners();
  }
}
