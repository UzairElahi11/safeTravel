import 'package:flutter/material.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/l10n/locale_keys.g.dart';

import 'package:safe/constants/typedef.dart';

class TextFieldValidatorImpl implements TextFieldValidator {
  @override
  bool handleValidation(TextEditingController controller,
      {FocusNode? focusNode,
      OnTextFieldErrorCallBack? onError,
      String? defaultErrorMessage,
      TextFormFieldMapErrorUsingConditions? mapErrorMessageUsingConditions,
      TextFormFieldValidityFlag? formValidityFlag}) {
    if (mapErrorMessageUsingConditions != null) {
      if (mapErrorMessageUsingConditions(controller.text).isError) {
        if (onError != null) {
          onError(
            mapErrorMessageUsingConditions(controller.text).errorMessage ??
                defaultErrorMessage ??
                LocaleKeys.required.translatedString(),
          );
        }
        if (formValidityFlag != null) {
          formValidityFlag(false);
        }
        return false;
      } else {
        if (onError != null) {
          onError(null);
        }
        if (formValidityFlag != null) {
          formValidityFlag(true);
        }
        return true;
      }
    } else {
      if (controller.text.trim().isEmpty) {
        if (onError != null) {
          onError(
            defaultErrorMessage ?? LocaleKeys.required.translatedString(),
          );
        }
        if (formValidityFlag != null) {
          formValidityFlag(false);
        }
        return false;
      } else {
        if (onError != null) {
          onError(null);
        }
        if (formValidityFlag != null) {
          formValidityFlag(true);
        }
      }
      return true;
    }
  }

  @override
  bool validateTextField(TextEditingController controller,
      {FocusNode? focusNode,
      String? defaultErrorMessage,
      OnTextFieldErrorCallBack? onError,
      TextFormFieldMapErrorUsingConditions? mapErrorMessageUsingConditions,
      TextFormFieldValidityFlag? formValidityFlag}) {
    controller.addListener(() {
      handleValidation(controller,
          focusNode: focusNode,
          defaultErrorMessage: defaultErrorMessage,
          onError: onError,
          mapErrorMessageUsingConditions: mapErrorMessageUsingConditions,
          formValidityFlag: formValidityFlag);
    });
    return handleValidation(controller,
        focusNode: focusNode,
        defaultErrorMessage: defaultErrorMessage,
        onError: onError,
        mapErrorMessageUsingConditions: mapErrorMessageUsingConditions,
        formValidityFlag: formValidityFlag);
  }
}
