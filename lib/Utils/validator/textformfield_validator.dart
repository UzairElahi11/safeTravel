import 'package:flutter/material.dart';

import 'package:safe/constants/typedef.dart';

abstract class TextFieldValidator {
  bool validateTextField(TextEditingController controller,
      {FocusNode? focusNode,
      String? defaultErrorMessage,
      OnTextFieldErrorCallBack? onError,
      TextFormFieldMapErrorUsingConditions? mapErrorMessageUsingConditions,
      TextFormFieldValidityFlag? formValidityFlag});

  bool handleValidation(TextEditingController controller,
      {FocusNode? focusNode,
      String? defaultErrorMessage,
      OnTextFieldErrorCallBack? onError,
      TextFormFieldMapErrorUsingConditions? mapErrorMessageUsingConditions,
      TextFormFieldValidityFlag? formValidityFlag});
}
