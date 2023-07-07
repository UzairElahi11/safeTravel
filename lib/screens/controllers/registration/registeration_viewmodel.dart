import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/locator.dart';
import 'package:safe/model/login-register/register_model.dart';
import 'package:safe/server_manager/server_manager.dart';
import 'package:safe/l10n/locale_keys.g.dart';

class RegistrationViewModel with ChangeNotifier, ApiCalling {
  bool isHidden = false;
  bool checkBox = false;
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  //DEFINING THE ERROR TEXTS
  String? passwordValidationError;
  String? emailValidationError;
  String? fullNameValidationError;
  String? confirmPasswordErrorValidator;
  final textFieldValidator = locator<TextFieldValidator>();
  RegisterModel? registerModel;

  void init() {}

  checkBoxHandler(bool check) {
    checkBox = check;
    notifyListeners();
  }

  bool validate() {
    bool emailValidated = textFieldValidator.validateTextField(
      email,
      mapErrorMessageUsingConditions: (text) {
        if (email.text.isEmpty) {
          return TextFieldValidatorModel(
              isError: true,
              errorMessage:
                  LocaleKeys.emailValidatorErrorText.translatedString());
        } else if (!AppUtil.emailRegex.hasMatch(text)) {
          return TextFieldValidatorModel(
            isError: true,
            errorMessage: LocaleKeys.emailMissMatchErrorText.translatedString(),
          );
        }
        return TextFieldValidatorModel(isError: false);
      },
      onError: (text) {
        emailValidationError = text;
        notifyListeners();
      },
    );

    bool passwordValidated = textFieldValidator.validateTextField(
      password,
      defaultErrorMessage:
          LocaleKeys.passwordValidatorErrorText.translatedString(),
      onError: (text) {
        passwordValidationError = text;
        notifyListeners();
      },
    );
    bool confirmpasswordValidated = textFieldValidator.validateTextField(
      confirmPassword,
      defaultErrorMessage:
          LocaleKeys.passwordValidatorErrorText.translatedString(),
      onError: (text) {
        confirmPasswordErrorValidator = text;
        notifyListeners();
      },
    );
    bool fullNameValidated = textFieldValidator.validateTextField(
      fullName,
      defaultErrorMessage: LocaleKeys.nameValidatorErrorText.translatedString(),
      onError: (text) {
        fullNameValidationError = text;
        notifyListeners();
      },
    );

    return emailValidated &
        passwordValidated &
        confirmpasswordValidated &
        fullNameValidated;
  }

  register(
      {required String email,
      required BuildContext context,
      required String password,
      required fullName,
      required void Function(
        bool success,
      ) completion}) {
    registerApiCalling(
        fullName: fullName,
        pasword: password,
        email: email,
        context: context,
        onForeground: true,
        callBack: (success, json) {
          // ignore: unnecessary_type_check
          if (json != null && json is Map) {
            // response model adding data
            registerModel = RegisterModel.fromJson(json);
            if (registerModel?.token != null) {
              UserDefaults.setToken(registerModel!.token!);
              debugPrint(registerModel?.token);
            }
            //  debugPrint("Response of login " + json.toString());
            completion(
              success,
            );
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

  socialLogin(
      {required String email,
      required BuildContext context,
      required String token,
      required String userName,
      required String providerName,
      required void Function(
        bool success,
      ) completion}) {
    socialLoginApiCalling(
        token: token,
        providerName: providerName,
        email: email,
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          // ignore: unnecessary_type_check
          if (json != null && json is Map) {
            // response model adding data
            registerModel = RegisterModel.fromJson(json);
            if (registerModel?.token != null && registerModel?.data != null) {
              // UserDefaults.setToken(registerModel.token!);
              await UserDefaults.setToken(registerModel!.token!);
              await UserDefaults.setEmailAndUserName(
                  registerModel?.data?.name ?? "",
                  registerModel?.data?.email ?? "");
              debugPrint(registerModel?.token);
            }
            //  debugPrint("Response of login " + json.toString());
            completion(
              success,
            );
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
  registerApiCalling(
      {required String email,
      required String pasword,
      required String fullName,
      required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.register(email, pasword, fullName, (responseBody, success) {
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

  socialLoginApiCalling(
      {required String email,
      required String token,
      required providerName,
      required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.socialLogin(email, token, providerName,
          (responseBody, success) {
        debugPrint(responseBody.toString());
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