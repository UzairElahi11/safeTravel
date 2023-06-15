import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/all_texts.dart';
import 'package:safe/widgets/generic_text.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../Utils/extensions/lauchemail_extension.dart';
import '../../../Utils/validator/textformfield_model.dart';
import '../../../Utils/validator/textformfield_validator.dart';
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
    final List<String> words = futhureAssistanceText.split(' ');
    textSpans = words.map((word) {
      if (word.contains('@') && word.contains('.')) {
        return GestureDetector(
          onTap: () {
            word.launchEmail();
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
}
