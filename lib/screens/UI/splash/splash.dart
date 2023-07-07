import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as locatorr;
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/Utils/permission_handler_helper_model.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/locator.dart';
import 'package:safe/screens/UI/Welcome/welcome.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/login/login.dart';
import 'package:safe/screens/UI/user_details/user_data_manager.dart';

import '../user_details/userDetails.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  static const id = "/Welcome";

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  locatorr.Position? currentLocation;
  @override
  void initState() {
    if (Platform.isAndroid) {
      UserDataManager.getInstance().deviceType = "Android";
    } else if (Platform.isIOS) {
      UserDataManager.getInstance().deviceType = "IOS";
    }
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
        Future.delayed(
          const Duration(milliseconds: 100),
          () async {
            try {
              currentLocation = await locatorr.Geolocator.getCurrentPosition(
                  desiredAccuracy: locatorr.LocationAccuracy.high);
            } on Exception {
              currentLocation = null;
            }
            UserDataManager.getInstance().lat = currentLocation != null
                ? currentLocation!.latitude.toString()
                : "";
            UserDataManager.getInstance().long = currentLocation != null
                ? currentLocation!.latitude.toString()
                : "";
            await locator<LocalSecureStorage>()
                .readSecureStorage(AppUtil.isTermsAndConditionsAccepted);

            final val = await UserDefaults.getToken();

            log("value is $val");

            if (mounted) {
              val == null
                  ? AppUtil.pushRoute(
                      pushReplacement: true,
                      context: context,
                      route: const Login(),
                    )
                  : AppUtil.pushRoute(
                      pushReplacement: true,
                      context: context,
                      route: const UserDetailsView(
                        isFromLogin: true,
                      ),
                    );
            }
          },
        );
      } else if (value.permissionsResult == PermissionsResult.denied) {
        AppUtil.checkIfLocationPermissionAlreadyGranted().then((value) {
          if (value.permissionsResult == PermissionsResult.granted) {
            SchedulerBinding.instance.addPostFrameCallback(
              (_) async {
                try {
                  currentLocation =
                      await locatorr.Geolocator.getCurrentPosition(
                          desiredAccuracy: locatorr.LocationAccuracy.high);
                } on Exception {
                  currentLocation = null;
                }
                UserDataManager.getInstance().lat = currentLocation != null
                    ? currentLocation!.latitude.toString()
                    : "";
                UserDataManager.getInstance().long = currentLocation != null
                    ? currentLocation!.latitude.toString()
                    : "";
                await locator<LocalSecureStorage>()
                    .readSecureStorage(AppUtil.isTermsAndConditionsAccepted);

                if (mounted) {
                  await locator<LocalSecureStorage>().readSecureStorage(
                              AppUtil.isTermsAndConditionsAccepted) ==
                          "1"
                      ? AppUtil.pushRoute(
                          pushReplacement: true,
                          context: context,
                          route: const Login(),
                        )
                      : AppUtil.pushRoute(
                          pushReplacement: true,
                          context: context,
                          route: const Welcome(),
                        );
                }
              },
            );
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
