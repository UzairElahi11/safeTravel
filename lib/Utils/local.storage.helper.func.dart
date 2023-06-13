import 'dart:developer';

import 'package:safe/Utils/user_defaults.dart';

import 'app_util.dart';

class LocalStorageHelperFunctions {
//FOR LOGIN TOKEN
  static Future<String?> getloginToken() async {
    bearerToken = (await UserDefaults.getToken()) ?? "";
    log("token get $bearerToken");
    return bearerToken;
  }

// FOR ONBOARDING SCREEN
  static Future<bool?> getOnBoardingStatus() async {
    isFirstTime = (await UserDefaults.getOnBoarding()) ?? true;
    log("on boarding status $isFirstTime");
    return isFirstTime;
  }
}
