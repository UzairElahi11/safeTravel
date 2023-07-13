import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/url_constants.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/Utils/validator/textformfield_model.dart';
import 'package:safe/Utils/validator/textformfield_validator.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/locator.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:safe/screens/UI/user_details/user_data_manager.dart';

import '../../../dynamic_size.dart';
import '../../../model/get_labels.dart';
import '../../../server_manager/server_manager.dart';
import '../add_family_members/add_family_members_viewmodel.dart';
import '../disablity/disablity.dart';
import '../payment/payment_view.dart';

class UserDetailsViewModel extends ChangeNotifier
    with GetAllLabels, CreateBooking {
  GetLabels getLabelsModel = GetLabels();
  List<String> listNames = [];
  int totalNumberOfListInDataObject = 0;

  List<dynamic>? listData = [];

  List<String> listItems = [];

  List<bool> healthCheckList = [];
  List<bool> medicalCheckList = [];
  List<bool> foodAlergiesList = [];
  List<bool> disablitiesList = [];

  /// these are lists of items where the checkbox are seleted
  List<dynamic> selectedHealthIssueList = [];
  List<dynamic> selectedMediacalIssuesList = [];
  List<dynamic> selectedFoodIssuesList = [];
  List<dynamic> selectedDisablitiesIssueList = [];

  List<String> base64Images = [];

  File? image;
  List<File?> reports = <File?>[];
  DateTime selectedDate = DateTime.now();
  ScrollController scrollController = ScrollController();
  String formattedDate = "";
  String base64Image = "";

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

  navigate(BuildContext context, bool isFromLogin) async {
    if (validate()) {
      selectedDisablitiesIssueList = disablitiesList
          .asMap()
          .entries
          .where((entry) {
            int index = entry.key;
            bool value = entry.value;
            return value && index < listData![0].length;
          })
          .map((entry) => listData![0][entry.key])
          .toList();
      selectedHealthIssueList = healthCheckList
          .asMap()
          .entries
          .where((entry) {
            int index = entry.key;
            bool value = entry.value;
            return value && index < listData!.length;
          })
          .map((entry) => listData![1][entry.key])
          .toList();
      selectedMediacalIssuesList = medicalCheckList
          .asMap()
          .entries
          .where((entry) {
            int index = entry.key;
            bool value = entry.value;
            return value && index < listData![2].length;
          })
          .map((entry) => listData![2][entry.key])
          .toList();
      selectedFoodIssuesList = foodAlergiesList
          .asMap()
          .entries
          .where((entry) {
            int index = entry.key;
            bool value = entry.value;
            return value && index < listData![3].length;
          })
          .map((entry) => listData![3][entry.key])
          .toList();

      log("selected is $selectedDisablitiesIssueList");
      log("selected is $selectedFoodIssuesList");

      log("selected is $selectedMediacalIssuesList");

      log("selected is $selectedHealthIssueList");

      Map<String, dynamic> memberDetails = {
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "dob": formattedDate,
        "picture": base64Image,
        "health_conditions": selectedHealthIssueList,
        "medical_allergies": selectedMediacalIssuesList,
        "disabilities": selectedDisablitiesIssueList,
        "health_reports": base64Images,
        "food_allergies": selectedFoodIssuesList
      };

      maintingUserDetails!.add(memberDetails);

      Map<String, dynamic> bodyToBePosted = {
        "emergency_contact": {
          "name":
             nameController.text.trim(),
          "phone": 
              phoneNumberController
              .text
              .trim(),
          "notes":
             notesController.text.trim()
        },
        "booking": {
          "arrival": CalendarViewModel.of(listen: false).arrivalfocusDay,
          "departure": CalendarViewModel.of(listen: false).departureFocusDay
        },
        "family_members": {
          "adults": familyMembersList[0]['numberOfMembers'],
          "childrens": familyMembersList[1]['numberOfMembers'],
          "new_borns": familyMembersList[2]['numberOfMembers'],
          "members": maintingUserDetails
        }
      };

      log("here is th $bodyToBePosted");

      notifyListeners();

      log("body to be [osted] :$bodyToBePosted");
      AppUtil.pushRoute(
        context: context,
        route: Disability(
          isFromLogin: isFromLogin,
          body: memberDetails,
        ),
      );
    }
  }

  fillTheListWhereSelected() async {
    // await compareAndSelectTheList(selectedHealthIssueList, healthCheckList);
    // await compareAndSelectTheList(selectedMediacalIssuesList, medicalCheckList);
    // await compareAndSelectTheList(selectedFoodIssuesList, healthCheckList);
    // await compareAndSelectTheList(
    //     selectedDisablitiesIssueList, healthCheckList);

    // log("health issues $selectedHealthIssueList");
    // log("medical issues $selectedMediacalIssuesList");

    // log("food issues $selectedFoodIssuesList");

    // log("disabilities issues $selectedDisablitiesIssueList");
  }

  //compare the bool list with relative list of disabilities and only choose which are selected
  // compareAndSelectTheList(
  //     List<String> issuesList, List<bool> selectedBoolList) {
  //   issuesList = selectedBoolList
  //       .asMap()
  //       .entries
  //       .where((entry) {
  //         int index = entry.key;
  //         bool value = entry.value;
  //         return value && index < listItems.length;
  //       })
  //       .map((entry) => listItems[entry.key])
  //       .toList();
  // }

  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickedImage!.path);
    Uint8List bytes = image!.readAsBytesSync();
    String base64Image = base64Encode(bytes);
    print(base64Image);

    notifyListeners();
  }

  Future<void> selectImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imagee = await picker.pickImage(source: ImageSource.gallery);
      image = File(imagee!.path);
      Uint8List bytes = image!.readAsBytesSync();
      base64Image = base64Encode(bytes);

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

      base64Images = reports.map((file) {
        List<int> bytes = file!.readAsBytesSync();
        String base64Image = base64Encode(bytes);
        return base64Image;
      }).toList();

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
              foodAlergiesList = List<bool>.generate(
                  getLabelsModel.data?.foodAllergies?.length ?? 0,
                  (index) => false);
              disablitiesList = List<bool>.generate(
                  getLabelsModel.data?.disabilities?.length ?? 0,
                  (index) => false);

              notifyListeners();

              // }
              completion(success);
            } else {}
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
      foodAlergiesList[index] = !foodAlergiesList[index];
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
      return foodAlergiesList[index];
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
      foodAlergiesList.add(false);
    } else {
      disablitiesList.add(false);
    }
  }

  static UserDetailsViewModel of({required bool listen}) {
    return Provider.of(Keys.mainNavigatorKey.currentState!.context,
        listen: listen);
  }

  bool isLoading = false;

  Future<void> makePostRequest(
      Map<String, dynamic> json) async {
    // final url = Uri.parse('http://staysafema.com/api/create-booking');
    final String valueUrl = "http://staysafema.com/api/create-booking";

    final dio = Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers["Authorization"] = "Bearer $bearerToken";
    // print(formData.toString());
    dio.post(valueUrl, data: json).then((value) {
      try {
        isLoading = true;
        notifyListeners();

        if (value.statusCode == 200) {
          // Successful request
          debugPrint('Request successful!');
          debugPrint('Response body: ${value.data}');

          if (value.data['status'] == 1) {
            showDialog(
              context: Keys.mainNavigatorKey.currentState!.context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Police"),
                  content: const Text(
                      "Police is on way at you current location please wait and and be safe"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        AppUtil.pop(context: context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                );
              },
            );

            UserDefaults.setIsFormPosted("1");
            Navigator.of(Keys.mainNavigatorKey.currentState!.context)
                .pushReplacement(
              MaterialPageRoute(
                builder: (context) => const PaymentView(),
              ),
            );
          }
        } else {
          // Request failed
          debugPrint('Request failed with status: ${value.statusCode}');

          isLoading = false;
          notifyListeners();
        }
      } catch (e) {
        debugPrint(e.toString());
        isLoading = false;
        notifyListeners();
      } finally {
        isLoading = false;
        notifyListeners();
      }
    });
  }

  createBookingFunc(
      {required BuildContext context,
      required Map<String, dynamic> body,
      required void Function(
        bool success,
      ) completion}) {
    // log
    createBooking(
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of create booking $json");

          if (json != null) {
            debugPrint("Response of booking $json");

            // if (json["status"] == 0) {
            //   AppUtil.showWarning(
            //     context: context,
            //     bodyText: json["message"] ?? "",
            //     title: "Retry",
            //     barrierDismissible: false,
            //     handler: (action) {
            //       completion(
            //         false,
            //       );
            //       Navigator.of(context, rootNavigator: true).pop();
            //     },
            //   );
            // } else {}
            // completion(
            //   success,
            // );
            completion(
              success,
            );
          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(
                  false,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
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

mixin CreateBooking {
  bool apiCallingProgress = false;
  createBooking(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.createBooking((responseBody, success) {
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

List<dynamic> maintingUserDetails = [];
