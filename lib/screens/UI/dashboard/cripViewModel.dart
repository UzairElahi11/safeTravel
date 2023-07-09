import 'package:crisp/models/main.dart';
import 'package:crisp/models/user.dart';
import 'package:flutter/material.dart';


class CrsipViewModel extends ChangeNotifier {
  CrispMain? crispMain;

  crispInit() {
    // ProfileViewMoodel.of(listen: false).userInfo(
    //     context: Keys.mainNavigatorKey.currentState!.context,
    //     completion: (completed) {});

    crispMain = CrispMain(
      websiteId: '83172768-a2f8-447f-80cf-c0f185637734',
    );

    crispMain?.register(
      user: CrispUser(
        email: "jhondoe@gmail.com",
        avatar: 'https://avatars2.githubusercontent.com/u/16270189?s=200&v=4',
        nickname: "jhon doe",
        phone: "5511987654321",
      ),
    );
  }
}
