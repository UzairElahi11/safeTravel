import 'package:flutter/material.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/model/helper/services_helperModel.dart';
import 'package:safe/screens/UI/user_details/user_data_manager.dart';
import 'package:safe/server_manager/server_manager.dart';

class DashboardViewModel with ChangeNotifier, ApiCalling {
  List<ServicesHelperModel> services = [];
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

  callPolice(
      {required BuildContext context,
      required void Function(
        bool success,
      ) completion}) {
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
      ServerManager.callPolice(lat,long, (responseBody, success) {
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
