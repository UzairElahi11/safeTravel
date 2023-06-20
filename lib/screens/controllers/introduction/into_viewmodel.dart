import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/locator.dart';

import 'package:safe/Utils/app_util.dart';
import 'package:safe/screens/UI/registration/registration_view.dart';

class IntroViewModel with ChangeNotifier {
  bool isHidden = false;
  bool checkBox = false;

  List<String> language = ["English", "Spanish"];
  List<String> enLanguages = ["English", "Spanish"];
  List<String> esLanguages = ["Inglés", "español"];

  void init() {}

  checkBoxHandler(bool check) {
    checkBox = check;
    notifyListeners();
  }

  Future<bool> acceptConditionAndMoveNext(BuildContext context) async {
    log("data is  ${await locator<LocalSecureStorage>().writeIntoSecureStorage("$checkBox", AppUtil.isTermsAndConditionsAccepted)}");
    if (checkBox) {
// await locator<LocalSecureStorage>()
//           .writeIntoSecureStorage("$checkBox", AppUtil.isTermsAndConditionsAccepted);

      // await locator<LocalSecureStorage>()
      // .writeIntoSecureStorage("1", AppUtil.isTermsAndConditionsAccepted);
      if (context.mounted) {
        AppUtil.pushRoute(
          context: context,
          route: const RegistationView(),
        );
      }
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

  ///This function is responsible to set the language code in the local storage
  ///So that next time when we will come back to the application so we will check
  ///if the current language is last time selected by user so we will call that
  ///language in the start of application.
  Future<String> storeLocaleLanguageCode(String langaugeCode) async {
    final storint = await locator<LocalSecureStorage>()
        .writeIntoSecureStorage(langaugeCode, AppUtil.isEnglish);

    log("storing is $storint");

    return langaugeCode;
  }
}
