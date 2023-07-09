import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/keys.dart';
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

  static AddFamilyMembersViewModel of({required bool listen}) {
    return Provider.of(Keys.mainNavigatorKey.currentState!.context,
        listen: listen);
  }

  ///Add the members
  addMembers(int index, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyDialog(
          cancelCallBack: () {
            AppUtil.pop(context: context);
          },
          proceedCallBack: () {
            familyMembersList[index]["numberOfMembers"] += 1;
            AppUtil.pushRoute(
                context: context,
                route: const UserDetailsView(isFromLogin: false));
          },
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
