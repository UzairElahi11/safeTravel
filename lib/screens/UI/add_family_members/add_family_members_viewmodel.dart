
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/screens/UI/user_details/userDetail_viewModel.dart';
import 'package:safe/widgets/dialogBoxAddNewPerson.dart';

class AddFamilyMembersViewModel extends ChangeNotifier {
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
            UserDetailsViewModel.of(listen: false).base64Images.clear();

            AppUtil.pop(context: context);
          },
          proceedCallBack: () {
            familyMembersList[index]["numberOfMembers"] += 1;
            notifyListeners();
            int count = 3;

            Navigator.of(context).popUntil((_) => count-- <= 0);
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
