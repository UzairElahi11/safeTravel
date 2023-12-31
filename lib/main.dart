import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/Utils/routes.dart';
import 'package:safe/app_providers.dart';
import 'package:safe/constants/keys.dart';
import 'package:safe/locale.dart';
import 'package:safe/locator.dart';
import 'package:safe/observers/navigation_observer.dart';
import 'package:safe/screens/UI/splash/splash.dart';
import 'package:safe/screens/UI/user_details/user_data_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling a background message ${message.messageId}');
  debugPrint(message.notification!.title);
  debugPrint(message.notification!.body);
  // ignore: prefer_typing_uninitialized_variables
  var flutterLocalNotificationsPlugin;
  flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'launch_background',
        ),
      ));
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await initializeDependencies();

  // await Firebase.initializeApp();
  // await Firebase.initializeApp().then((_) async {
  await Firebase.initializeApp().then((_) async {
    FirebaseMessaging.instance.requestPermission().then((value) async {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then((value) async {
        final languageStored = await locator<LocalSecureStorage>()
            .readSecureStorage(AppUtil.isEnglish);
        runApp(
          EasyLocalization(
            supportedLocales: L10n.all,
            path: 'assets/translations',
            fallbackLocale:
                languageStored == "English" ? L10n.all[0] : L10n.all[1],
            child: const MyApp(),
          ),
        );
      });
    });
  });
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]).then(
  //   (value) async {
  //     final languageStored = await locator<LocalSecureStorage>()
  //         .readSecureStorage(AppUtil.isEnglish);
  //     runApp(
  //       EasyLocalization(
  //         supportedLocales: L10n.all,
  //         path: 'assets/translations',
  //         fallbackLocale:
  //             languageStored == "English" ? L10n.all[0] : L10n.all[1],
  //         child: const MyApp(),
  //       ),
  //     );
  // },
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: locator<AppProviders>().appProviders,
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    pushNotifications();
    return Sizer(builder: ((context, orientation, deviceType) {
      return ScreenUtilInit(
          designSize: const Size(1920, 1080),
          builder: (context, child) {
            return MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              initialRoute: Splash.id,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              navigatorKey: Keys.mainNavigatorKey,
              navigatorObservers: [PawaNavigationObserver()],
              builder: (BuildContext context, Widget? widget) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
                  return getErrorWidget(context, errorDetails);
                };
                return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                    child: widget!);
              },
              theme: ThemeData(
                primaryColor: Colors.blue,
                scaffoldBackgroundColor: Colors.white,
                canvasColor: Colors.transparent,
              ),
            );
          });
    }));
  }
}

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Container(
    color: Colors.transparent,
    child: const Text(
      "",
    ),
  );
}

LatLng? extractCoordinatesFromNotification(String notificationText) {
  RegExp latLngRegExp = RegExp(r'Lat:\s*([\d.]+),\s*Lng:\s*([\d.]+)');
  Match? match = latLngRegExp.firstMatch(notificationText);

  if (match != null) {
    final latitude = double.tryParse(match.group(1)!);
    final longitude = double.tryParse(match.group(2)!);
    if (latitude != null && longitude != null) {
      return LatLng(latitude, longitude);
    }
  }

  return null;
}

String notificationMessage = "";

pushNotifications() async {
   var fcmToken;
   if (Platform.isIOS) {
      await FirebaseMessaging.instance.getAPNSToken().then((token) {
        fcmToken = token ?? "";
      });
     log("Fcm token is ${fcmToken.toString()}");
    } else {
      await FirebaseMessaging.instance.getToken().then((token) {
       fcmToken = token ?? "";

         log("Fcm token is ${fcmToken.toString()}");
      });
     
    }
  print("fcm" + fcmToken.toString());
  UserDataManager.getInstance().fcmToken = fcmToken.toString();
  var initializationSettingAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var intializationSetting = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingsIOS,
      macOS: null);
  flutterLocalNotificationsPlugin.initialize(intializationSetting);

  // flutterLocalNotificationsPlugin.initialize(intializationSetting,
  //     onDidReceiveNotificationResponse: (details) async {
  //   log("details are :::: ${details.payload}");
  //   if (details.payload != null) {
  //     notificationMessage = details.payload ?? "";
  //     final LatLng? coordinates =
  //         extractCoordinatesFromNotification(details.payload ?? "");

  //     if (coordinates != null) {
  //       final url =
  //           'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}';
  //       if (await canLaunchUrl(
  //         Uri.parse(url),
  //       )) {
  //         await launchUrl(
  //           Uri.parse(url),
  //         );
  //       }
  //     }
  //   }
  // });
  
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ));
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ));
      final LatLng? coordinates =
          extractCoordinatesFromNotification(notification.body ?? "");

      if (coordinates != null) {
        final url =
            'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}';
        if (await canLaunchUrl(
          Uri.parse(url),
        )) {
          await launchUrl(
            Uri.parse(url),
          );
        }
      }
    }
  });
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ));
      final LatLng? coordinates =
          extractCoordinatesFromNotification(notification.body ?? "");

      if (coordinates != null) {
        final url =
            'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}';
        if (await canLaunchUrl(
          Uri.parse(url),
        )) {
          await launchUrl(
            Uri.parse(url),
          );
        }
      }
    }
  });
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ));
      final LatLng? coordinates =
          extractCoordinatesFromNotification(notification.body ?? "");

      if (coordinates != null) {
        final url =
            'https://www.google.com/maps/search/?api=1&query=${coordinates.latitude},${coordinates.longitude}';
        if (await canLaunchUrl(
          Uri.parse(url),
        )) {
          await launchUrl(
            Uri.parse(url),
          );
        }
      }
    }
  } as FutureOr Function(RemoteMessage? value));
}
