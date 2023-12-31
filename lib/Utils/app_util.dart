import 'dart:convert';
import 'dart:developer';

// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/Utils/permission_handler_helper_model.dart';
import 'package:safe/dynamic_size.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtil {
  AppUtil._();
  static const String font = "Comfortaa";
  static double _deviceHeight = 0, _deviceWidth = 0;

  static const hintPassword = "*********";
  static const emailHint = "Email";
  static const fullNameHint = "Full Name";

  static String isTermsAndConditionsAccepted = "isTCAccepted";
  static String isEnglish = "isEnglish?";

  static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static RegExp spaceNotAllowedRegex = RegExp(r'\s');

  static RegExp emailDetectionRegex =
      RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');

  // _paddingTop = 0,
  // _paddingBottom = 0;

  static Future<void> launchUrls(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static double deviceHeight(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    try {
      _deviceHeight = mediaQueryData.size.height;
    } catch (e) {
      log(
        e.toString(),
      );
    }
    return _deviceHeight;
  }

  static double deviceWidth(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);

    try {
      _deviceWidth = mediaQueryData.size.width;
    } catch (e) {
      log(
        e.toString(),
      );
    }
    return _deviceWidth;
  }

  static void pushRoute(
      {required BuildContext context,
      bool fromRoot = false,
      Widget? route,
      Function? valueCallBack,
      bool pushReplacement = false,
      RouteSettings? settings}) {
    try {
      _push(
          context: context,
          route: _getRoute(settings, route!),
          valueCallBack: valueCallBack,
          fromRoot: fromRoot,
          pushReplacement: pushReplacement);
    } catch (e) {
      debugPrint(
        e.toString(),
      );
    }
  }

  static dynamic decodeString(String responseBody) {
    return json.decode(responseBody);
  }

  static bool showingLoader = false;
  static int loaderCount = 0;

  static void showLoader(
      {required BuildContext? context, bool resetCount = false}) {
    // if (resetCount) {
    //   loaderCount = 1;
    //   showingLoader = false;
    // } else
    loaderCount++;
    debugPrint("showLoader $loaderCount");
    if (context == null || showingLoader) return;
    showingLoader = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: SizedBox(
                height: DynamicSize.width(0.45, context),
                width: DynamicSize.width(0.45, context),
                child: Lottie.asset("assets/lottie/loader.json"),
              ),
            ),
          );
        });
  }

  static Future<PermissionHandlerHelperModel>
      checkIfLocationPermissionAlreadyGranted() async {
    PermissionHandlerHelperModel permissionHandlerHelperModel =
        PermissionHandlerHelperModel(
            permissionsResult: PermissionsResult.denied, permissionName: "");

    // Request location permission

   final statuss =  await Geolocator.requestPermission();


    var status = await Permission.location.request();

    if (status.isGranted) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResult.granted,
          permissionName: "Permission.location");
    } else if (status.isDenied) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResult.denied,
          permissionName: "Permission.location");
    } else if (status.isPermanentlyDenied) {
      permissionHandlerHelperModel = PermissionHandlerHelperModel(
          permissionsResult: PermissionsResult.permanentlyDenied,
          permissionName: "Permission.location");
    }

    return permissionHandlerHelperModel;
  }

  static void dismissLoader({required BuildContext context}) {
    loaderCount--;
    if (loaderCount < 0) {
      loaderCount = 0;
    }
    debugPrint("dismissloader : $loaderCount");
    showingLoader = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void showWarning(
      {required BuildContext context,
      String? title,
      String? bodyText,
      String? btnTitle,
      bool barrierDismissible = true,
      PawaHandler? handler,
      bool forNotification = false}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title ?? "Error"),
            content: Text(bodyText ?? "Error"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    AppUtil.pop(context: context);
                  },
                  child: const Text('Close')),
            ],
          );
        });
  }

  // static void showFCMNotificationForIOS(
  //     {required RemoteMessage remoteMessage}) {
  //   // AppUtil.showLog(LoggerConstants.firebaseLoggerKey, "json:::${remoteMessage.notification.title}");

  //   // NotificationPayLoadResponseModel model = NotificationPayLoadResponseModel.fromNotification(remoteMessage);

  //   ///insert into the local db
  //   // LocalDbUtil.getInstance().insertFCMNotificationData(fcmTitle: remoteMessage?.notification?.title ?? "", fcmBody: remoteMessage?.notification?.body ?? "");
  //   // if (model != null) {
  //   // FlutterLocalNotificationsPlugin().show(
  //   //   remoteMessage.notification.title.hashCode,
  //   //   remoteMessage.notification.title,
  //   //   remoteMessage.notification.body,
  //   //   const NotificationDetails(
  //   //       iOS: IOSNotificationDetails(
  //   //         presentAlert: true,
  //   //         presentBadge: true,
  //   //         presentSound: true,
  //   //       )), /*payload: AppUtil.getEncodedJSONString(model.toJson())*/
  //   // );
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     //AppUtil.showLog(LoggerConstants.firebaseLoggerKey, 'A new onMessageOpenedApp event was published!');
  //   });
  //   // }
  //   remoteMessage.data.clear();
  //   //todo:: handle below
  //   // if (UserDataManager.getInstance().isUserAlreadyLoggedIn()) {
  //   //   ///user logged in
  //   // } else {
  //   //   ///user not logged in
  //   // }
  // }

  static void pop(
      {required BuildContext context,
      bool fromRoot = false,
      var valueToReture}) {
    if (Navigator.of(context, rootNavigator: fromRoot).canPop()) {
      Navigator.of(context, rootNavigator: fromRoot).pop(valueToReture);
    }
  }

  static MaterialPageRoute _getRoute(RouteSettings? settings, Widget route) {
    return settings != null
        ? MaterialPageRoute(
            settings: settings,
            builder: ((context) {
              return route;
            }))
        : MaterialPageRoute(builder: ((context) {
            return route;
          }));
  }

  static void _push(
      {required BuildContext context,
      bool fromRoot = false,
      var route,
      Function? valueCallBack,
      bool pushReplacement = false}) {
    if (pushReplacement) {
      Navigator.of(context, rootNavigator: fromRoot)
          .pushReplacement(route)
          .then((value) {
        if (valueCallBack != null) {
          valueCallBack(value);
        }
      });
    } else {
      Navigator.of(context, rootNavigator: fromRoot)
          .push(route)
          .then((dynamic value) {
        if (valueCallBack != null) {
          valueCallBack(value);
        }
      });
    }
  }
}

class PawaAlertHandler {
  String? title;
  bool showWhiteButton = false;
  PawaHandler? handler;
}

String? bearerToken;
String nameUser = "";
String email = "";
String loginTokenKey = "LoginToken";
String onBoardingKey = "onBoardingKey";
String isPayment = "isPayment";
String isFormPosted = "isFormPosted";
String skip = "skip";
String emailKey = "emailKey";
String userNameKey = "UserNameKey";
bool isFirstTime = true;
String countryCode = "+212";
String helplineNumber = "661060114";

AccessToken? facebookToken;
Map<String, dynamic>? facebookUserData;
String publicKeyStripe =
    "pk_test_51M2D1ECcTUIOQ9MlHx82jO3oGqleOMKvBub1sYxHYTODiKzxwwAWb3hUiqgvHXCf92WXbklGIYgjLtpvh5DiQ9ll00eCtUxgsy";

typedef PawaHandler = void Function(PawaAlertHandler action);

String mapMarkerKey = "currentLocation";
