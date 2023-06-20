import 'package:flutter/material.dart';

class AddFamilyMembersViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> familyMembersList = [
    {
      "member": "Adults",
      "isChecked": false,
      "numberOfMembers": 0,
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
  addMembers(int index) {
    familyMembersList[index]["numberOfMembers"] += 1;
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
    familyMembersList[index]['isChecked'] = !familyMembersList[index]['isChecked'];
    notifyListeners();
  }

}
