import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/locator.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:safe/screens/UI/disablity/disablity.dart';

import '../../../model/get_labels.dart';
import '../../../server_manager/server_manager.dart';

class UserDetailsViewModel extends ChangeNotifier with GetAllLabels {
  GetLabels getLabelsModel = GetLabels();
  List<String> listNames = [];
  int totalNumberOfListInDataObject = 0;

  List<dynamic>? listData = [];

  List<String> listItems = [];

  List<bool> healthCheckList = [];
  List<bool> medicalCheckList = [];
  List<bool> foodAlergiesLies = [];
  List<bool> disablitiesList = [];

  Map<String, dynamic> bodyToBePosted = {
    "emergency_contact": {"name": "", "phone": "", "notes": ""},
    "booking": {
      "arrival": CalendarViewModel.of(listen: false).arrivalfocusDay,
      "departure": CalendarViewModel.of(listen: false).arrivalfocusDay,
    },
    "family_members": {
      "adults": 1,
      "childrens": 0,
      "new_borns": 0,
      "members": [
        {
          "first_name": "",
          "last_name": "",
          "dob": "",
          "picture": "",
          "health_conditions": ["condition 1", "condition 2"],
          "medical_allergies": ["medical allergy 1", "medical allergy 2"],
          "food_allergies": ["food allergy 1", "food allergy 2"],
          "disabilities": ["disabilities 1", "disabilities 2"],
          "health_reports": ["base64 string 1", "base64 string 2"]
        },
        {
          "first_name": "",
          "last_name": "",
          "dob": "",
          "picture": "",
          "health_conditions": ["condition 1", "condition 2"],
          "medical_allergies": ["medical allergy 1", "medical allergy 2"],
          "food_allergies": ["food allergy 1", "food allergy 2"],
          "disabilities": ["disabilities 1", "disabilities 2"],
          "health_reports": ["base64 string 1", "base64 string 2"]
        }
      ]
    }
  };

  File? image;
  List<File?> reports = <File?>[];
  DateTime selectedDate = DateTime.now();
  ScrollController scrollController = ScrollController();
  String formattedDate = "";

  //Textediting controllers
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addItemsController = TextEditingController();

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

  navigate(BuildContext context, bool isFromLogin) {
    if (validate()) {
      AppUtil.pushRoute(
        context: context,
        route: Disability(isFromLogin: isFromLogin),
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
      for (var element in imagesList) {
        reports.add(File(element.path));
      }

      //  reports.addAll(File(imagesList!.path))

      // image = File(imagee!.path);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getLabels(
      {required BuildContext context,
      required void Function(bool success) completion}) {
    getAllLabelss(
        context: context,
        onForeground: true,
        callBack: (success, json) {
          if (json != null && json is Map) {
            // response model adding data

            getLabelsModel = GetLabels.fromJson(json);
            if (getLabelsModel.status == 1) {
              // if (mainScreenModel.data != null) {
              //   for (var element in mainScreenModel.data!) {
              //     latlong.add(LatLng(double.parse(element.latitude!),
              //         double.parse(element.longitude!)));
              //   }
              //   debugPrint("latitude" + latlong![0].latitude.toString());

              listNames = getLabelsModel.data?.toJson().keys.toList() ?? [];

              totalNumberOfListInDataObject =
                  getLabelsModel.data?.toJson().keys.length ?? 0;

              listData = getLabelsModel.data?.toJson().values.toList();

              healthCheckList = List<bool>.generate(
                  getLabelsModel.data?.healthConditions?.length ?? 0,
                  (index) => false);
              medicalCheckList = List<bool>.generate(
                  getLabelsModel.data?.medicalAllergies?.length ?? 0,
                  (index) => false);
              foodAlergiesLies = List<bool>.generate(
                  getLabelsModel.data?.foodAllergies?.length ?? 0,
                  (index) => false);
              disablitiesList = List<bool>.generate(
                  getLabelsModel.data?.disabilities?.length ?? 0,
                  (index) => false);

              notifyListeners();

              // }
              completion(success);
            } else {
              // completion(success);
              // AppUtil.showWarning(
              //   context: context,
              //   title: "Error",
              //   barrierDismissible: false,
              //   handler: (action) {
              //     completion(false);
              //     Navigator.of(context, rootNavigator: true).pop();
              //   },
              // );
            }
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(false);
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }

  //add the hitem to the respective list
  addItem(int index) {
    listData![index].add(addItemsController.text);
    addNewBoolToListWhenAddNewItem(index);
    notifyListeners();

    addItemsController.clear();
    Keys.mainNavigatorKey.currentState!.pop();
  }

  checkboxes(int index, int mainIndex) {
    if (mainIndex == 0) {
      healthCheckList[index] = !healthCheckList[index];
    } else if (mainIndex == 1) {
      medicalCheckList[index] = !medicalCheckList[index];
    } else if (mainIndex == 2) {
      foodAlergiesLies[index] = !foodAlergiesLies[index];
    } else {
      disablitiesList[index] = !disablitiesList[index];
    }
    notifyListeners();
  }

  bool getBoolValue(int index, int mainIndex) {
    if (mainIndex == 0) {
      return healthCheckList[index];
    } else if (mainIndex == 1) {
      return medicalCheckList[index];
    } else if (mainIndex == 2) {
      return foodAlergiesLies[index];
    } else {
      return disablitiesList[index];
    }
  }

  addNewBoolToListWhenAddNewItem(int mainIndex) {
    if (mainIndex == 0) {
      healthCheckList.add(false);
    } else if (mainIndex == 1) {
      medicalCheckList.add(false);
    } else if (mainIndex == 2) {
      foodAlergiesLies.add(false);
    } else {
      disablitiesList.add(false);
    }
  }
}

mixin GetAllLabels {
  bool apiCallingProgress = false;
  getAllLabelss(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.getLabels((responseBody, success) {
        debugPrint(responseBody.toString());
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
