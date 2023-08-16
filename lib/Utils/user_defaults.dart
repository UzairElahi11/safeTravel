import 'package:shared_preferences/shared_preferences.dart';

import 'package:safe/Utils/app_util.dart';

class UserDefaults {
  //SAVE THE TOKEN IN THE LOCAL STORAGE
  static setToken(String token) async {
    SharedPreferences sharedPreferencesSet =
        await SharedPreferences.getInstance();
    sharedPreferencesSet.setString(loginTokenKey, token);
    bearerToken = token;
    return token;
  }

  static setPayment(String payment) async {
    SharedPreferences sharedPreferencesSet =
        await SharedPreferences.getInstance();
    sharedPreferencesSet.setString(isPayment, payment);
    // bearerToken = payment;
    return payment;
  }

  static setIsFormPosted(String payment) async {
    SharedPreferences sharedPreferencesSet =
        await SharedPreferences.getInstance();
    sharedPreferencesSet.setString(isFormPosted, payment);
    // bearerToken = payment;
    return payment;
  }

  /// set the skip of the payment in the local storage
  static setPaymentSkip(String skipValue) async {
    SharedPreferences sharedPreferencesSet =
        await SharedPreferences.getInstance();
    sharedPreferencesSet.setString(skip, skipValue);
    return skipValue;
  }

  static clearAllData() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();

    sharedPreferencesGet.clear();
  }

  /// get the payment skip from the local storage
  static getSkipPaymentFromLocalStorage<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final getLocalSkip = sharedPreferencesGet.getString(skip);
    return getLocalSkip;
  }

  //SAVE THE User Name and email
  static setEmailAndUserName(String name, String emaill) async {
    SharedPreferences sharedPreferencesSet =
        await SharedPreferences.getInstance();
    sharedPreferencesSet.setString(userNameKey, name);
    sharedPreferencesSet.setString(emailKey, emaill);
    email = emaill;
    nameUser = name;
    return name;
  }

  //GET THE TOKEN FROM THE LOCAL STORAGE
  static getToken<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final getToken = sharedPreferencesGet.getString(loginTokenKey);
    return getToken;
  }

  //GET THE TOKEN FROM THE LOCAL STORAGE
  static getPayment<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final getToken = sharedPreferencesGet.getString(isPayment);
    return getToken;
  }

  static clearPayment() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    sharedPreferencesGet.remove(isPayment);
  }

  static getIsForm<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final getToken = sharedPreferencesGet.getString(isFormPosted);
    return getToken;
  }

  static clearform() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    sharedPreferencesGet.remove(isFormPosted);
  }

  //GET THE email FROM THE LOCAL STORAGE
  static getEmail<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final userEmail = sharedPreferencesGet.getString(emailKey);
    return userEmail;
  }

  //GET THE username FROM THE LOCAL STORAGE
  static getUserName<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final userName = sharedPreferencesGet.getString(userNameKey);
    return userName;
  }

  //CLEAR THE TOKEN FROM THE LOCAL STORAGE
  static clearLoginToken() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    sharedPreferencesGet.remove(loginTokenKey);
    // sharedPreferencesGet.remove(key)
  }

  static clearUserNameAndEmail() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    sharedPreferencesGet.remove(emailKey);
    sharedPreferencesGet.remove(userNameKey);
  }

  //SET FOR ONBOARDING
  static setOnBoarding() async {
    SharedPreferences sharedPreferencesSet =
        await SharedPreferences.getInstance();
    sharedPreferencesSet.setBool(onBoardingKey, false);
    isFirstTime = false;
    return isFirstTime;
  }

//GET FOT ON BOARDING
  static getOnBoarding<String>() async {
    SharedPreferences sharedPreferencesGet =
        await SharedPreferences.getInstance();
    final getOnBoardingStatus = sharedPreferencesGet.getBool(onBoardingKey);
    return getOnBoardingStatus;
  }
}
