import 'package:flutter/widgets.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/locator.dart';

class DisabilityViewModel extends ChangeNotifier {
  Map<String, bool> disabilityTypes = {};

  //Textediting controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  //Error text for the fields
  String? nameError;
  String? phoneError;
  String? notesError;

  //validate the fields, should not empty while submitting the form
  bool validate() {
    bool nameValidated = locator<TextFieldValidator>().validateTextField(
        nameController, mapErrorMessageUsingConditions: (text) {
      if (text.isEmpty) {
        return TextFieldValidatorModel(
          isError: true,
          errorMessage: LocaleKeys.notEmpty.translatedString(),
        );
      }

      return TextFieldValidatorModel(isError: false);
    }, onError: (errorText) {
      nameError = errorText;
    });
    bool phoneValidated = locator<TextFieldValidator>().validateTextField(
        phoneNumberController, mapErrorMessageUsingConditions: (text) {
      if (text.isEmpty) {
        return TextFieldValidatorModel(
          isError: true,
          errorMessage: LocaleKeys.notEmpty.translatedString(),
        );
      }
      return TextFieldValidatorModel(isError: false);
    }, onError: (errorText) {
      phoneError = errorText;
    });
    bool notesValidated = locator<TextFieldValidator>().validateTextField(
        notesController, mapErrorMessageUsingConditions: (text) {
      if (text.isEmpty) {
        return TextFieldValidatorModel(
          isError: true,
          errorMessage: LocaleKeys.notEmpty.translatedString(),
        );
      }
      return TextFieldValidatorModel(isError: false);
    }, onError: (errorText) {
      notesError = errorText;
    });

    notifyListeners();
    return nameValidated & phoneValidated & notesValidated;
  }
}
