import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/locator.dart';
import 'package:safe/screens/UI/disablity/disablity.dart';

class UserDetailsViewModel extends ChangeNotifier {
  File? image;
  List<File?> reports = <File?>[];
  DateTime selectedDate = DateTime.now();
  ScrollController scrollController = ScrollController();
  String formattedDate = "";

  List<Map<String, dynamic>> disabilityTypes = [
    {"name": "Awais", "isChecked": false},
    {"name": "Sarwar", "isChecked": true},
    {"name": "Khan", "isChecked": true},
    {"name": "first", "isChecked": true},
    {"name": "first", "isChecked": true},
    {"name": "first", "isChecked": true},
    {"name": "first", "isChecked": true},
  ];
  List<Map<String, dynamic>> heathDisablities = [
    {"name": "Fitness", "isChecked": false},
    {"name": "Fitness", "isChecked": true},
    {"name": "Fitness", "isChecked": true},
    {"name": "Fitness", "isChecked": true},
    {"name": "Fitness", "isChecked": true},
    {"name": "Fitness", "isChecked": true},
    {"name": "Fitness", "isChecked": true},
  ];

  //Textediting controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  //dateofbirthSelection
  void seletedDate(DateTime? date) {
    if (date != null) {
      selectedDate = date;
      String month = selectedDate.month.toString();
      String day = selectedDate.day.toString();
      if (month.length == 1) {
        month = "0$month";
      }
      if (day.length == 1) {
        day = "0$day";
      }
      formattedDate = "${selectedDate.year}/$month/$day";
      dateOfBirthController.text = formattedDate;
      notifyListeners();
    }
  }

  //Error text for the fields
  String? firstnameError;
  String? lastNameLastError;
  String? dateofBirthError;

  //validate the fields, should not empty while submitting the form
  bool validate() {
    bool firstNameValidator = locator<TextFieldValidator>().validateTextField(
        firstNameController, mapErrorMessageUsingConditions: (text) {
      if (text.isEmpty) {
        return TextFieldValidatorModel(
          isError: true,
          errorMessage: LocaleKeys.notEmpty.translatedString(),
        );
      }

      return TextFieldValidatorModel(isError: false);
    }, onError: (errorText) {
      firstnameError = errorText;
    });
    bool lastNaneValidator = locator<TextFieldValidator>().validateTextField(
        lastNameController, mapErrorMessageUsingConditions: (text) {
      if (text.isEmpty) {
        return TextFieldValidatorModel(
          isError: true,
          errorMessage: LocaleKeys.notEmpty.translatedString(),
        );
      }
      return TextFieldValidatorModel(isError: false);
    }, onError: (errorText) {
      lastNameLastError = errorText;
    });
    bool dateOfBirthValidator = locator<TextFieldValidator>().validateTextField(
        dateOfBirthController, mapErrorMessageUsingConditions: (text) {
      if (text.isEmpty) {
        return TextFieldValidatorModel(
          isError: true,
          errorMessage: LocaleKeys.notEmpty.translatedString(),
        );
      }
      return TextFieldValidatorModel(isError: false);
    }, onError: (errorText) {
      dateofBirthError = errorText;
    });

    notifyListeners();
    return firstNameValidator & lastNaneValidator & dateOfBirthValidator;
  }

  //Change the checkbox value
  changeCheckBoxvalue(int index) {
    disabilityTypes[index]['isChecked'] = !disabilityTypes[index]['isChecked'];
    notifyListeners();
  }

  navigate(BuildContext context,bool isFromLogin) {
    if (validate()) {
      AppUtil.pushRoute(
        context: context,
        route:  Disability(isFromLogin:isFromLogin),
      );
    }
  }

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedImage!.path);
    notifyListeners();
  }

  Future<void> selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imagee = await picker.pickImage(source: ImageSource.gallery);
      image = File(imagee!.path);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> selectImageReport() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> imagesList = await picker.pickMultiImage();
      imagesList.forEach((element) {
        reports.add(File(element.path));
      });

      //  reports.addAll(File(imagesList!.path))

      // image = File(imagee!.path);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
