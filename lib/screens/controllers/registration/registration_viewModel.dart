import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/constants/all_texts.dart';
import 'package:safe/locator.dart';

class RegistrationViewModel with ChangeNotifier {
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
              isError: true, errorMessage: emailValidatorErrorText);
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
      password,
      defaultErrorMessage: passwordValidatorErrorText,
      onError: (text) {
        passwordValidationError = text;
        notifyListeners();
      },
    );
    bool confirmpasswordValidated = textFieldValidator.validateTextField(
      confirmPassword,
      defaultErrorMessage: passwordValidatorErrorText,
      onError: (text) {
        confirmPasswordErrorValidator = text;
        notifyListeners();
      },
    );
    bool fullNameValidated = textFieldValidator.validateTextField(
      fullName,
      defaultErrorMessage: nameValidatorErrorText,
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
}
