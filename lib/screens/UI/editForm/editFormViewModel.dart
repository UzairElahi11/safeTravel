import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/server_manager/server_manager.dart';

import '../../../constants/keys.dart';

class ProfileViewModel with ChangeNotifier, ApiCalling {
  List<List<bool>> checkboxStates = [];
  List<dynamic> savingTheListsDataFromDataObject = [];

  List<String> listOfKeys = [];

  TextEditingController addItemsController = TextEditingController();
  Map<dynamic, dynamic> getEditProfileData = {};
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

              for (var i in dataList) {
                if (i is Map<String, dynamic>) {
                  i.forEach((key, value) {
                    if (value is List) {
                      savingTheListsDataFromDataObject.add(value);
                      listOfKeys.add(key);
                    }
                  });
                }
              }

              for (int i = 0;
                  i < savingTheListsDataFromDataObject.length;
                  i++) {
                checkboxStates.add(List.filled(
                    savingTheListsDataFromDataObject[i].length, false));
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
  }

  addItem(int index) {
    savingTheListsDataFromDataObject[index].add(addItemsController.text);

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
    checkboxStates[index][innerIndex] = value!;

    notifyListeners();
  }

  void decodeImage(String image) {
    final decodedBytes = base64Decode(image);

    var file = io.File("decodedBezkoder.png");
    file.writeAsBytesSync(decodedBytes);
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
