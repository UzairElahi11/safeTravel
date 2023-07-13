import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/carValidation.dart';
import 'package:safe/server_manager/server_manager.dart';

class PaymentViewModel with ChangeNotifier, paymentApiCallingClass {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expController = TextEditingController();
  String? cardNumberValidator;
  String? cvvValidator;
  String? expValidator;

  validator(BuildContext context) {
    expValidator = CardUtils.validateDate(expController.text);
    cardNumberValidator = CardUtils.validateCardNum(cardNumberController.text);
    cvvValidator = CardUtils.validateCVV(cvvController.text);
    if (!(expValidator != null &&
        expValidator!.isNotEmpty &&
        cvvValidator != null &&
        expValidator!.isNotEmpty &&
        expValidator != null &&
        expValidator!.isNotEmpty)) {
      payment(
          context: context,
          completion: (success) {
            if (success) {
              UserDefaults.setPayment("1");
              showToaster(context);
              AppUtil.pushRoute(
                  pushReplacement: true,
                  context: context,
                  route: const DashboardView());
            }
          });
    }

    notifyListeners();
  }

  void showToaster(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Payment Successful}"),
    ));
  }

  payment(
      {required BuildContext context,
      required void Function(
        bool success,
      ) completion}) {
    paymentApiCalling(
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
}

mixin paymentApiCallingClass {
  bool apiCallingProgress = false;
  paymentApiCalling(
      {required String cardNumber,
      required String cvv,
      required String expDate,
      required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.payment(cardNumber, cvv, expDate, (responseBody, success) {
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
          AppUtil.pushRoute(context: context, route: DashboardView());
        }
      });
    }
  }
}
