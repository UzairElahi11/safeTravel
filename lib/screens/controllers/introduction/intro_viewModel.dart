import 'package:flutter/material.dart';

import '../../../Utils/app_util.dart';
import '../../UI/registration/registration_view.dart';

class IntroViewModel with ChangeNotifier {
  bool isHidden = false;
  bool checkBox = false;

  void init() {}

  checkBoxHandler(bool check) {
    checkBox = check;
    notifyListeners();
  }

  bool acceptConditionAndMoveNext(BuildContext context) {
    if (checkBox) {
      AppUtil.pushRoute(
        context: context,
        route: const RegistationView(),
      );
      return true;
    }
    return false;
  }

  List<String> languages = ["English", "Spanish"];
}
