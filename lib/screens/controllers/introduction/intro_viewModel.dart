import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../Utils/app_util.dart';
import '../../UI/registration/registration_view.dart';

class IntroViewModel with ChangeNotifier {
  bool isHidden = false;
  bool checkBox = false;

  List<String> language = [];

  List<String> enLanguages = ["English", "Spanish"];
  List<String> esLanguages = ["Inglés", "español"];

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

  //This function is responsible to checkt if the language is spanish then dropdown list change it's text to spanish otherwise to english
  List<String> changeDropDownLangauge(BuildContext context) {
    if (context.locale.countryCode == 'en') {
      language = enLanguages;
      return language;
    }
    language = esLanguages;
    return language;
  }
}
