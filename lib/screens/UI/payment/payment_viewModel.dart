import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/carValidation.dart';
import 'package:safe/server_manager/server_manager.dart';

import '../../../constants/keys.dart';
import '../user_details/user_data_manager.dart';

class PaymentViewModel with ChangeNotifier, paymentApiCallingClass {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expController = TextEditingController();
  String? cardNumberValidator;
  String? cvvValidator;
  String? expValidator;
  LocalSecureStorage localSecureStorage = LocalSecureStorage();

  validator(BuildContext context) async {
    expValidator = CardUtils.validateDate(expController.text);
    cardNumberValidator = CardUtils.validateCardNum(cardNumberController.text);
    cvvValidator = CardUtils.validateCVV(cvvController.text);
    if (expValidator != 'This field is required' &&
        expValidator != 'Expiry month is invalid' &&
        expValidator != 'Expiry year is invalid' &&
        expValidator != 'Card has expired' &&
        cvvValidator != 'CVV is invalid' &&
        cvvValidator != 'This field is required' &&
        cardNumberValidator != 'This field is required' &&
        cardNumberValidator != 'Card is invalid') {
      payment(
          context: context,
          completion: (success) async {
            if (success) {
              await UserDefaults.setPayment("1");
              await UserDefaults.setPaymentSkip("0");
              // ignore: use_build_context_synchronously
              showToaster(context);
              // ignore: use_build_context_synchronously
              AppUtil.pushRoute(
                  pushReplacement: true,
                  context: context,
                  route: const DashboardView());
            }
          });
    } else {
      log("no valid");
    }

    notifyListeners();
  }

  void showToaster(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Payment Successful"),
    ));
  }

  payment(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    paymentApiCalling(
      lat: UserDataManager.getInstance().lat,
      long: UserDataManager.getInstance().long,
        cardNumber: cardNumberController.text,
        cvv: cvvController.text,
        expDate: expController.text,
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

  /// Safe the skip in the local storage
  skipSaveLocally() async {
    await UserDefaults.setPaymentSkip('1');

    AppUtil.pushRoute(
      pushReplacement: true,
      context: Keys.mainNavigatorKey.currentState!.context,
      route: const DashboardView(),
    );
  }
}

mixin paymentApiCallingClass {
  bool apiCallingProgress = false;
  paymentApiCalling(
      {required String cardNumber,
      required String cvv,
      required String expDate,
      required String lat,
      required String long,
      required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.payment(cardNumber, cvv, expDate, lat, long,
          (responseBody, success) {
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
        } else {
          AppUtil.pushRoute(context: context, route: const DashboardView());
        }
      });
    }
  }
}
