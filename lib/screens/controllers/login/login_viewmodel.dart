import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/locator.dart';
import 'package:safe/model/login-register/login_model.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/payment_view.dart';
// import 'package:safe/screens/UI/disablity/disablity.dart';
import 'package:safe/screens/UI/user_details/userDetails.dart';
import 'package:safe/screens/controllers/registration/registeration_viewmodel.dart';
import 'package:safe/server_manager/server_manager.dart';
import 'package:safe/service/social_auth_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../UI/user_details/user_data_manager.dart';

class LoginViewModel with ChangeNotifier, loginApiCallingClass {
  //initializing the text editing controllers
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  LoginModel? loginModel;
  final Authenticate authenticate = Authenticate();

  Authenticate socialLogin = Authenticate();

  //TEXT FORM FIELD VALIDATOR
  final textFieldValidator = locator<TextFieldValidator>();

  //PASSWORD BOOL
  ValueNotifier<bool> showPassword = ValueNotifier(false);

  //DEFINING THE ERROR TEXTS
  String? passwordValidationError;
  String? emailValidationError;

  //
  List<Widget> textSpans = [];

  //VALIDATION
  bool validate() {
    bool emailValidated = textFieldValidator.validateTextField(
      emailController,
      mapErrorMessageUsingConditions: (text) {
        if (emailController.text.isEmpty) {
          return TextFieldValidatorModel(
              isError: true, errorMessage: emailValidationError);
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
      passwordController,
      defaultErrorMessage: passwordValidationError,
      onError: (text) {
        passwordValidationError = text;
        notifyListeners();
      },
    );

    return emailValidated & passwordValidated;
  }

  void showToaster(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Welcome ${loginModel?.data!.name.toString()}"),
    ));
  }

  /// if validated then we will move to the next screeb
  loginUser(BuildContext context) {
    if (validate()) {
      AppUtil.pushRoute(
        context: context,
        route: const UserDetailsView(
          isFromLogin: true,
        ),
      );
    }
  }

  login(
      {required String email,
      required BuildContext context,
      required String password,
      required void Function(bool success, int formFillForm, int isPaymenDone)
          completion}) {
    loginApiCalling(
        lat: UserDataManager.getInstance().lat,
        long: UserDataManager.getInstance().long,
        pasword: password,
        email: email,
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
                  completion(false, 0, 0);
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {
              loginModel = LoginModel.fromJson(json);
              if (loginModel?.token != null) {
                await UserDefaults.setToken(loginModel!.token!);
                // locator<LocalSecureStorage>().writeIntoSecureStorage(value, key)
                await UserDefaults.setEmailAndUserName(
                    loginModel?.data?.name ?? "",
                    loginModel?.data?.email ?? "");
                if (loginModel?.data?.onTrip == 1) {
                  if (loginModel?.data?.payment == 1) {
                    completion(success, 1, 1);
                    return;
                  }
                  completion(success, 1, 0);
                }
              }
              completion(success, 0, 0);

              log("Token coming from the application ${loginModel!.token}");

              log("here is our token =========> $bearerToken");
            }
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(false, 0, 0);
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }

//Visible password
  bool visiblePassFunc() {
    showPassword.value = !showPassword.value;
    return showPassword.value;
  }

  //DETECT THE EMAIL IN THE TEXT
  String? extractEmail(String text) {
    Iterable<Match> matches = AppUtil.emailDetectionRegex.allMatches(text);
    if (matches.isNotEmpty) {
      return matches.first.group(0);
    }
    return null;
  }

// CHECK AND HIGHTLIGHT THE EMAIL WHERE PRESENT IN THE TEXT
  checkingEmailText() {
    final List<String> words =
        LocaleKeys.futhureAssistanceText.translatedString().split(' ');
    textSpans = words.map((word) {
      if (word.contains('@') && word.contains('.')) {
        return GestureDetector(
          onTap: () {
            launchEmail(word);
          },
          child: GenericText(
            '$word ',
            style: AppStyles.medium14.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.blackColor,
              decoration: TextDecoration.underline,
            ),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return GenericText(
          '$word ',
          style: AppStyles.medium14.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor,
          ),
          textAlign: TextAlign.center,
        );
      }
    }).toList();
  }

  appleLogin() {
    socialLogin.signInWithApple();
  }

  facebookLoginFunc(BuildContext context) async {
    UserCredential user = await socialLogin.facebookLogin();

    log("display name  is ${user.user!.displayName}");
    log("login token is ${user.credential!.accessToken}");

    log("username  is ${user.additionalUserInfo!.username}");

    log("email  is ${user.user!.email}");

    log("profile data is ${user.additionalUserInfo!.profile} ");

    if (context.mounted) {
      RegistrationViewModel().socialLogin(
          email: user.user?.email ?? "",
          context: Keys.mainNavigatorKey.currentState!.context,
          token: user.credential!.accessToken.toString(),
          userName: user.user?.displayName ?? "",
          providerName: "facebook",
          completion: (check, form, isPayment) async {
            showToaster(context);
            if (check) {
              if (form == 1 && isPayment == 1) {
              await  UserDefaults.setIsFormPosted("1");
                // ignore: use_build_context_synchronously
                AppUtil.pushRoute(
                    context: context,
                    route: const DashboardView(),
                    pushReplacement: true);
              } else if (form == 1 && isPayment == 0) {
                await UserDefaults.setIsFormPosted("1");
                // ignore: use_build_context_synchronously
                AppUtil.pushRoute(
                  context: context,
                  route: const PaymentView(),
                );
              } else {
                AppUtil.pushRoute(
                  context: context,
                  pushReplacement: true,
                  route: const UserDetailsView(
                    isFromLogin: true,
                  ),
                );
              }
            }
          });
    }
  }

  googleLogin() {
    socialLogin.googleSignInMethod();
  }

  //LAUCH THE EMAIL IN THE EMAIL APPLICATION
  void launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      queryParameters: {'To': email},
      path: email,
    );

    if (await canLaunchUrl(
      Uri.parse(
        emailLaunchUri.toString(),
      ),
    )) {
      await launchUrl(
        Uri.parse(
          emailLaunchUri.toString(),
        ),
      );
    } else {
      throw 'Could not launch $email';
    }
  }
}

mixin loginApiCallingClass {
  bool apiCallingProgress = false;
  loginApiCalling(
      {required String email,
      required String pasword,
      required String lat,
      required String long,
      required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.login(email, pasword, lat, long, (responseBody, success) {
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
