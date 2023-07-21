import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/keys.dart';
// import 'package:safe/Utils/extensions/string.extension.dart';
// import 'package:safe/Utils/validator/textformfield_model.dart';
// import 'package:safe/Utils/validator/textformfield_validator.dart';
// import 'package:safe/l10n/locale_keys.g.dart';
// import 'package:safe/locator.dart';
import 'package:safe/screens/UI/add_family_members/add_family_members.dart';

class DisabilityViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> disabilityTypes = [
    {"name": "Awais", "isChecked": false},
    {"name": "Sarwar", "isChecked": true},
    {"name": "Khan", "isChecked": true},
    {"name": "first", "isChecked": true},
    {"name": "first", "isChecked": true},
    {"name": "first", "isChecked": true},
    {"name": "first", "isChecked": true},
  ];

  //Textediting controllers

  //Error text for the fields
  String? nameError;
  String? phoneError;
  String? notesError;

  //validate the fields, should not empty while submitting the form
  bool validate() {
    return true;
    // bool nameValidated = locator<TextFieldValidator>().validateTextField(
    //     nameController, mapErrorMessageUsingConditions: (text) {
    //   if (text.isEmpty) {
    //     return TextFieldValidatorModel(
    //       isError: true,
    //       errorMessage: LocaleKeys.notEmpty.translatedString(),
    //     );
    //   }

    //   return TextFieldValidatorModel(isError: false);
    // }, onError: (errorText) {
    //   nameError = errorText;
    // });
    // bool phoneValidated = locator<TextFieldValidator>().validateTextField(
    //     phoneNumberController, mapErrorMessageUsingConditions: (text) {
    //   if (text.isEmpty) {
    //     return TextFieldValidatorModel(
    //       isError: true,
    //       errorMessage: LocaleKeys.notEmpty.translatedString(),
    //     );
    //   }
    //   return TextFieldValidatorModel(isError: false);
    // }, onError: (errorText) {
    //   phoneError = errorText;
    // });
    // bool notesValidated = locator<TextFieldValidator>().validateTextField(
    //     notesController, mapErrorMessageUsingConditions: (text) {
    //   if (text.isEmpty) {
    //     return TextFieldValidatorModel(
    //       isError: true,
    //       errorMessage: LocaleKeys.notEmpty.translatedString(),
    //     );
    //   }
    //   return TextFieldValidatorModel(isError: false);
    // }, onError: (errorText) {
    //   notesError = errorText;
    // });

    // notifyListeners();
    // return nameValidated & phoneValidated & notesValidated;
  }

  //Change the checkbox value
  changeCheckBoxvalue(int index) {
    disabilityTypes[index]['isChecked'] = !disabilityTypes[index]['isChecked'];
    notifyListeners();
  }

  navigate(BuildContext context, Map<String, dynamic> body) {
    if (validate()) {
      AppUtil.pushRoute(
        context: context,
        route: AddFamilyMembers(body: body),
      );
    }
  }

  static DisabilityViewModel of({required bool listen}) {
    return Provider.of(Keys.mainNavigatorKey.currentState!.context,
        listen: listen);
  }
}

TextEditingController nameController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController notesController = TextEditingController();
