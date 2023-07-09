import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/server_manager/server_manager.dart';

class ProfileViewModel with ChangeNotifier, ApiCalling {
  init(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProfileForm(context: context, completion: (success) {});
    });
  }

  void showToasterPolice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Account Updated"),
    ));
  }

  getProfileForm(
      {required BuildContext context,
      required void Function(
        bool success,
      ) completion}) {
    getFormApiCalling(
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
              // pharmacyListModel = PharmacyListModel.fromJson(json);
              // if (pharmacyListModel != null &&
              //     pharmacyListModel?.data != null &&
              //     pharmacyListModel!.data.isNotEmpty) {
              //   pharmacyList = pharmacyListModel!.data;
              // }
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
  getFormApiCalling(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.getProfileForm((responseBody, success) {
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
