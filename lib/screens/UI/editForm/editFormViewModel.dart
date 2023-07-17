import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/server_manager/server_manager.dart';

import '../../../constants/keys.dart';

class ProfileViewModel with ChangeNotifier, ApiCalling, UpdateBooking {
  List<List<bool>> checkboxStates = [];
  List<dynamic> savingTheListsDataFromDataObject = [];

  List<dynamic> listOfKeys = [];

  List<dynamic> updatedHealthConditionsList = [];
  List<String> updatedFoodConditionsList = [];
  List<String> updatedDisabilityList = [];

  TextEditingController addItemsController = TextEditingController();
  Map<dynamic, dynamic> getEditProfileData = {};

  updateTheCheckList() {
    //updated health list
    for (int i = 0; i < checkboxStates[0].length; i++) {
      if (checkboxStates[0][i] == true) {
        updatedHealthConditionsList.add(savingTheListsDataFromDataObject[0][i]);
      }
    }

    //updated food alergies list

    for (int i = 0; i < checkboxStates[1].length; i++) {
      if (checkboxStates[1][i] == true) {
        updatedFoodConditionsList.add(savingTheListsDataFromDataObject[1][i]);
      }
    }

    //updated Disabilities list

    for (int i = 0; i < checkboxStates[2].length; i++) {
      if (checkboxStates[2][i] == true) {
        updatedDisabilityList.add(savingTheListsDataFromDataObject[2][i]);
      }
    }
  }

  updateProfile() async {
    await updateTheCheckList();

    Map<String, dynamic> json = {
      "family_members": [
        {
          "id": getEditProfileData['data'][0]['id'],
          "first_name": getEditProfileData['data'][0]['first_name'],
          "last_name": getEditProfileData['data'][0]['last_name'],
          "dob": getEditProfileData['data'][0]['dob'],
          "delete_old_picture": false,
          "picture": getEditProfileData['data'][0]['picture'],
          "health_conditions": updatedHealthConditionsList,
          "medical_allergies": [],
          "food_allergies": updatedFoodConditionsList,
          "disabilities": updatedDisabilityList,
          "old_health_reports": [],
          "health_reports": []
        }
      ]
    };

    updateBookingFunc(
      body: json,
      completion: (success) {
        log("success is $success");

        updatedDisabilityList.clear();
        updatedFoodConditionsList.clear();
        updatedHealthConditionsList.clear();
        checkboxStates.clear();
        savingTheListsDataFromDataObject.clear();
        listOfKeys.clear();

        Navigator.pop(Keys.mainNavigatorKey.currentState!.context);
      },
      context: Keys.mainNavigatorKey.currentState!.context,
    );
  }

  init(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProfileForm(context: context, completion: (success) {});
    });

  }

  void showToasterPolice(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Account Updated"),
    ));
  }

  updateBookingFunc(
      {required BuildContext context,
      required Map<String, dynamic> body,
      required void Function(
        bool success,
      )
          completion}) {
    // log
    updateBooking(
        json: body,
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of update booking $json");

          if (json != null) {
            debugPrint("Response of update $json");

            if (json["status"] == 0) {
              AppUtil.showWarning(
                context: context,
                bodyText: json["message"] ?? "",
                title: "Retry",
                barrierDismissible: false,
                handler: (action) {
                  completion(
                    false,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {}
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

  getProfileForm(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    getFormApiCalling(
        context: context,
        onForeground: true,
        callBack: (success, json) async {
          debugPrint("Response of login $json");

          if (json != null) {
            debugPrint("Response of login $json");

            if (json["status"] == 0) {
              AppUtil.showWarning(
                context: context,
                bodyText: json["message"] ?? "",
                title: "Retry",
                barrierDismissible: false,
                handler: (action) {
                  completion(
                    false,
                  );
                  Navigator.of(context, rootNavigator: true).pop();
                },
              );
            } else {
              getEditProfileData = json;

              notifyListeners();
              completion(
                success,
              );

              List<dynamic> dataList = getEditProfileData['data'];

              if (dataList.isNotEmpty) {
                if (dataList[0] is Map<String, dynamic>) {
                  dataList[0].forEach((key, value) {
                    if (value is List) {
                      savingTheListsDataFromDataObject.add(value);

                      listOfKeys.add(key);

                      log("memebers are $savingTheListsDataFromDataObject");
                    }
                  });
                }
              }

              for (int i = 0;
                  i < savingTheListsDataFromDataObject.length;
                  i++) {
                checkboxStates.add(
                  List.generate(
                    savingTheListsDataFromDataObject[i].length,
                    (index) => false,
                  ),
                );
              }
            }
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

    if (savingTheListsDataFromDataObject.isNotEmpty) {
      savingTheListsDataFromDataObject
          .removeAt(savingTheListsDataFromDataObject.last);
      listOfKeys.removeAt(listOfKeys.last);
    }
  }

  addItem(
    int index,
  ) {
    savingTheListsDataFromDataObject[index].add(addItemsController.text);

    checkboxStates[index].add(false);

    notifyListeners();

    addItemsController.clear();
    Keys.mainNavigatorKey.currentState!.pop();
  }

  //replace the underscore from the keys and we are changing it into our text
  String removeUnderScore(int index) {
    return listOfKeys[index].replaceAll('_', ' ');
  }

  // make the every sentence of the word upper case
  String firstLetterUpperCase(int index) {
    List<String> words = removeUnderScore(index).split(' ');

    return words.map((word) {
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
  }

  void updateCheckboxState(int index, int innerIndex, bool value) {
    checkboxStates[index][innerIndex] = value;

    notifyListeners();
  }

  void decodeImage(String image) {
    final decodedBytes = base64Decode(image);

    var file = io.File("decodedBezkoder.png");
    file.writeAsBytesSync(decodedBytes);
  }

  //convert the base64 image to string
  String base64String(Uint8List data) {
    return base64Encode(data);
  }
}

mixin ApiCalling {
  bool apiCallingProgress = false;
  getFormApiCalling(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.getProfileForm((responseBody, success) {
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

mixin UpdateBooking {
  bool apiCallingProgress = false;
  updateBooking(
      {required Map<String, dynamic> json,
      required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.updateBooking(json, (responseBody, success) {
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
