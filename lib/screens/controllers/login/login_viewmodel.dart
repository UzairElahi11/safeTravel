import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/all_texts.dart';
import 'package:safe/widgets/generic_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../Utils/validator/textformfield_model.dart';
import '../../../Utils/validator/textformfield_validator.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../../locator.dart';

class LoginViewModel extends ChangeNotifier {
  //initializing the text editing controllers
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
            errorMessage: emailMissMatchErrorText,
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
    final List<String> words = LocaleKeys.futhureAssistanceText.split(' ');
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
