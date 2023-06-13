import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/permission_handler_helper_model.dart';
import 'package:safe/screens/UI/Welcome/welcome.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const id = "/Welcome";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    moveTopNextPage(context);
  }

  @override
  Widget build(BuildContext context) {
    AppUtil.deviceHeight(context);
    AppUtil.deviceWidth(context);

    return Scaffold(
      // backgroundColor: PawaColor.instance.backgroundColor,
      body: Container(
        color: Colors.red,
      ),
    );
  }

  moveTopNextPage(BuildContext context) {
    AppUtil.checkIfLocationPermissionAlreadyGranted().then((value) {
      if (value.permissionsResult == PermissionsResult.granted) {
        Future.delayed(const Duration(milliseconds: 1000), () {
          AppUtil.pushRoute(
              pushReplacement: true,
              context: context,
              route: isFirstTime == true
                  ? const Welcome()
                  : (bearerToken == null || bearerToken == "")
                      ? const Welcome()
                      : Welcome());
        });
      } else if (value.permissionsResult == PermissionsResult.denied) {
        AppUtil.checkIfLocationPermissionAlreadyGranted().then((value) {
          if (value.permissionsResult == PermissionsResult.granted) {
            Future.delayed(const Duration(milliseconds: 3000), () {
              AppUtil.pushRoute(
                  pushReplacement: true,
                  context: context,
                  route: isFirstTime == true
                      ? const Welcome()
                      : (bearerToken == null || bearerToken == "")
                          ? const Welcome()
                          : Welcome());
            });
          } else {
            showDialog(
              context: context,
              builder: (context) => settingWidget(),
            );
          }
        });
      }
    });
  }

  Widget settingWidget() {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Location Needed",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text("To use this app location is required"),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              await Geolocator.openLocationSettings();
            },
            child: Center(
                child: Container(
              height: 30,
              width: 150,
              decoration: const BoxDecoration(color: Colors.black),
              child: const Center(
                  child: Text(
                "Open Settings",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
            )),
          )
        ],
      ),
    );
  }
}
