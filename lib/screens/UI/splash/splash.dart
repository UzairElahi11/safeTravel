import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator/geolocator.dart' as locatorr;
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/Utils/user_defaults.dart';
import 'package:safe/locator.dart';
import 'package:safe/screens/UI/Welcome/welcome.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/payment_view.dart';
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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            "assets/logo.png",
            height: 250.h,
          ),
        ),
      ),
    );
  }

  moveTopNextPage(BuildContext context) async {
    await Geolocator.requestPermission().then((value) {
      log("name of permision is $value");
      if (value == LocationPermission.whileInUse) {
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
                ? currentLocation!.longitude.toString()
                : "";
            await locator<LocalSecureStorage>()
                .readSecureStorage(AppUtil.isTermsAndConditionsAccepted);

            final val = await UserDefaults.getToken();
            final skipVal = await UserDefaults.getSkipPaymentFromLocalStorage();
            final payment = await UserDefaults.getPayment();
            final isForm = await UserDefaults.getIsForm();

            log("is form $isForm");
            if (val != null) {
              bearerToken = val;
            }

            log("value is $val");

            if (mounted) {
              if (val == null) {
                AppUtil.pushRoute(
                  pushReplacement: true,
                  context: context,
                  route: const Welcome(),
                );
              }
              if (val != null) {
                if (isForm == null && payment == null) {
                  AppUtil.pushRoute(
                    pushReplacement: true,
                    context: context,
                    route: const UserDetailsView(
                      isFromLogin: true,
                    ),
                  );
                } else if (isForm == '1' && payment == null) {
                  AppUtil.pushRoute(
                    pushReplacement: true,
                    context: context,
                    route: const PaymentView(),
                  );
                } else if (skipVal == "1") {
                  AppUtil.pushRoute(
                    pushReplacement: true,
                    context: context,
                    route: const DashboardView(),
                  );
                } else if (payment == '1' && skipVal == "0") {
                  AppUtil.pushRoute(
                    pushReplacement: true,
                    context: context,
                    route: const DashboardView(),
                  );
                } else {
                  AppUtil.pushRoute(
                    pushReplacement: true,
                    context: context,
                    route: const Welcome(),
                  );
                }
              }
            }
          },
        );
      } else if (value == LocationPermission.denied) {
        moveTopNextPage(context);
      } else if (value == LocationPermission.deniedForever) {
        log("permission permanentlyDenied");
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Column(
                    children: [
                      const Text(
                        "Location permission required",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          openAppSettings().then(
                            (value) => Navigator.of(context).pop(),
                          );
                        },
                        child: const Text("Open setting"),
                      ),
                    ],
                  ),
                ),
              );
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
