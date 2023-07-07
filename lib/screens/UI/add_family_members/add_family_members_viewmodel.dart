import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/screens/UI/user_details/userDetails.dart';
import 'package:safe/widgets/dialogBoxAddNewPerson.dart';

class AddFamilyMembersViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> familyMembersList = [
    {
      "member": "Adults",
      "isChecked": false,
      "numberOfMembers": 1,
    },
    {
      "member": "Children",
      "isChecked": false,
      "numberOfMembers": 0,
    },
    {
      "member": "New Born",
      "isChecked": false,
      "numberOfMembers": 0,
    },
  ];

  ///Add the members
  addMembers(int index, BuildContext context) {
    showDialog(
      context: context,
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
              child: GenericText('Cancel'),
            ),
          ],
        );
      },
    );

    notifyListeners();
  }

  ///Remove the members
  removeMembers(int index) {
    if (familyMembersList[index]["numberOfMembers"] > 0) {
      familyMembersList[index]["numberOfMembers"] -= 1;
    }

    notifyListeners();
  }

  //Change the checkbox value
  changeCheckBoxvalue(int index) {
    familyMembersList[index]['isChecked'] =
        !familyMembersList[index]['isChecked'];
    notifyListeners();
  }
}
