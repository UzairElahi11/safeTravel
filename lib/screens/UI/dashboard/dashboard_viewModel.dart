import 'package:flutter/material.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/model/helper/services_helperModel.dart';
import 'package:safe/model/pharmacy/pharmacyListModel.dart';
import 'package:safe/screens/UI/user_details/user_data_manager.dart';
import 'package:safe/server_manager/server_manager.dart';

import '../../../Utils/user_defaults.dart';

class DashboardViewModel with ChangeNotifier, ApiCalling {
  List<ServicesHelperModel> services = [];
  PharmacyListModel? pharmacyListModel;
  LocalSecureStorage localSecureStorage = LocalSecureStorage();
  List<Datum> pharmacyList = [];
  String skipvalue = "";
  Datum? list;
  init() {
    services.add(ServicesHelperModel(
        name: LocaleKeys.police.translatedString(),
        imagePath: AppImages.police,
        icon: AppImages.warning));
    services.add(ServicesHelperModel(
        name: LocaleKeys.medical.translatedString(),
        imagePath: AppImages.health,
        icon: AppImages.warning));
    services.add(ServicesHelperModel(
        name: LocaleKeys.pharmacy.translatedString(),
        imagePath: AppImages.pharmacy,
        icon: AppImages.warning));
  }

  void showToasterPolice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Police is on way"),
    ));
  }

  /// Read the skip local key from the local storage,
  /// if the key is 1 then you can show the pop up and
  /// navigate to payment screen else if 0 then you
  /// can directly call the api

  Future<String> readSkipValueLocally() async {
    await UserDefaults.getSkipPaymentFromLocalStorage().then(
      (value) => skipvalue = value,
    );

    return skipvalue;
  }

  callPolice(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    callPoliceApiCalling(
        lat: UserDataManager.getInstance().lat,
        long: UserDataManager.getInstance().long,
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of login $json");

          if (json != null) {
            debugPrint("Response of login $json");

            if (json["status"] == 0) {
              AppUtil.showWarning(
                context: context,
                bodyText: json["message"] ?? "",
                title: "Retry",
                barrierDismissible: false,
                handler: (action) {
                  completion(
                    false,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {
              // loginModel = LoginModel.fromJson(json);
              if (true) {
                // await UserDefaults.setToken(loginModel!.token!);
                // await UserDefaults.setEmailAndUserName(
                //     loginModel?.data?.name ?? "",
                //     loginModel?.data?.email ?? "");
              }
              completion(
                success,
              );
            }
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(
                  false,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }

  callHealth(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    callHealthApiCalling(
        lat: UserDataManager.getInstance().lat,
        long: UserDataManager.getInstance().long,
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of login $json");

          if (json != null) {
            debugPrint("Response of login $json");

            if (json["status"] == 0) {
              AppUtil.showWarning(
                context: context,
                bodyText: json["message"] ?? "",
                title: "Retry",
                barrierDismissible: false,
                handler: (action) {
                  completion(
                    false,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {
              // loginModel = LoginModel.fromJson(json);
              if (true) {
                // await UserDefaults.setToken(loginModel!.token!);
                // await UserDefaults.setEmailAndUserName(
                //     loginModel?.data?.name ?? "",
                //     loginModel?.data?.email ?? "");
              }
              completion(
                success,
              );
            }
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(
                  false,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }

  logOut(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    logoutApiCaaling(
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of login $json");

          if (json != null) {
            debugPrint("Response of login $json");

            if (json["status"] == 0) {
              AppUtil.showWarning(
                context: context,
                bodyText: json["message"] ?? "",
                title: "Retry",
                barrierDismissible: false,
                handler: (action) {
                  completion(
                    false,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {
              // loginModel = LoginModel.fromJson(json);
              if (true) {
                // await UserDefaults.setToken(loginModel!.token!);
                // await UserDefaults.setEmailAndUserName(
                //     loginModel?.data?.name ?? "",
                //     loginModel?.data?.email ?? "");
              }
              completion(
                success,
              );
            }
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(
                  false,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }

  getPharmacyList(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    getPharmacyApiCalling(
        lat: UserDataManager.getInstance().lat,
        long: UserDataManager.getInstance().long,
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of login $json");

          if (json != null) {
            debugPrint("Response of login $json");

            if (json["status"] == 0) {
              AppUtil.showWarning(
                context: context,
                bodyText: json["message"] ?? "",
                title: "Retry",
                barrierDismissible: false,
                handler: (action) {
                  completion(
                    false,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {
              pharmacyListModel = PharmacyListModel.fromJson(json);
              if (pharmacyListModel != null &&
                  pharmacyListModel?.data != null &&
                  pharmacyListModel!.data.isNotEmpty) {
                pharmacyList = pharmacyListModel!.data;
              }
              notifyListeners();
              completion(
                success,
              );
            }
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(
                  false,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }
}

mixin ApiCalling {
  bool apiCallingProgress = false;
  callPoliceApiCalling(
      {required BuildContext context,
      required lat,
      required long,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.callPolice(lat, long, (responseBody, success) {
        apiCallingProgress = false;
        if (onForeground) {
          AppUtil.dismissLoader(context: context);
        }
        if (success) {
          try {
            dynamic json = AppUtil.decodeString(responseBody);
            if (json != null && json is Map) {
              callBack(true, json);
            } else {
              callBack(false, json);
            }
          } catch (e) {
            if (onForeground) {
              AppUtil.showWarning(
                  context: context, title: "Error", bodyText: "Error");
            }
            callBack(false, null);
          }
        }
      });
    }
  }

  callHealthApiCalling(
      {required BuildContext context,
      required lat,
      required long,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.callHealth(lat, long, (responseBody, success) {
        apiCallingProgress = false;
        if (onForeground) {
          AppUtil.dismissLoader(context: context);
        }
        if (success) {
          try {
            dynamic json = AppUtil.decodeString(responseBody);
            if (json != null && json is Map) {
              callBack(true, json);
            } else {
              callBack(false, json);
            }
          } catch (e) {
            if (onForeground) {
              AppUtil.showWarning(
                  context: context, title: "Error", bodyText: "Error");
            }
            callBack(false, null);
          }
        }
      });
    }
  }

  logoutApiCaaling(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.logout((responseBody, success) {
        apiCallingProgress = false;
        if (onForeground) {
          AppUtil.dismissLoader(context: context);
        }
        if (success) {
          try {
            dynamic json = AppUtil.decodeString(responseBody);
            if (json != null && json is Map) {
              callBack(true, json);
            } else {
              callBack(false, json);
            }
          } catch (e) {
            if (onForeground) {
              AppUtil.showWarning(
                  context: context, title: "Error", bodyText: "Error");
            }
            callBack(false, null);
          }
        }
      });
    }
  }

  getPharmacyApiCalling(
      {required BuildContext context,
      required lat,
      required long,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.getPharmacy(lat, long, (responseBody, success) {
        apiCallingProgress = false;
        if (onForeground) {
          AppUtil.dismissLoader(context: context);
        }
        if (success) {
          try {
            dynamic json = AppUtil.decodeString(responseBody);
            if (json != null && json is Map) {
              callBack(true, json);
            } else {
              callBack(false, json);
            }
          } catch (e) {
            if (onForeground) {
              AppUtil.showWarning(
                  context: context, title: "Error", bodyText: "Error");
            }
            callBack(false, null);
          }
        }
      });
    }
  }
}
