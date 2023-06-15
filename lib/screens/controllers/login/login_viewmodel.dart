import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/all_texts.dart';

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
}
