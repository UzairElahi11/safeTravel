import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe/Utils/pawa_color.dart';
import 'package:safe/Utils/pawa_route.dart';
import 'package:safe/observers/navigation_observer.dart';
import 'package:safe/screens/UI/splash/splash.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';
import 'package:sizer/sizer.dart';

import 'Utils/local.storage.helper.func.dart';
import 'constants/keys.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await LocalStorageHelperFunctions.getloginToken();
  await LocalStorageHelperFunctions.getOnBoardingStatus();
  await Firebase.initializeApp();
  // await Firebase.initializeApp().then((_) async {
  //   FirebaseMessaging.instance.requestPermission().then((value) async {
  //     FirebaseMessaging.onBackgroundMessage(
  //         _firebaseMessagingBackgroundHandler);
  //     await flutterLocalNotificationsPlugin
  //         .resolvePlatformSpecificImplementation<
  //             AndroidFlutterLocalNotificationsPlugin>()
  //         ?.createNotificationChannel(channel);
  //   });
  // });

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MultiProvider(providers: [
      ChangeNotifierProvider<IntroViewModel>(
          create: (context) => IntroViewModel()),
    ], child: const App());
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
              debugShowCheckedModeBanner: false,
              initialRoute: Splash.id,
              onGenerateRoute: PawaRoutes.onGenerateRoute,
              key: Get.key,
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
                scaffoldBackgroundColor:
                    PawaColor.pawaBackGroundColors,
                canvasColor: Colors.transparent,
              ),
            );
          });
    }));
  }
}

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Container(
    color: PawaColor.transparentColor,
    child: Text(
      "",
      style:
          TextStyle(color: PawaColor.pawaBackGroundColor),
    ),
  );
}

pushNotifications() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  debugPrint(fcmToken.toString());
  var initializationSettingAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  var intializationSetting = InitializationSettings(
      android: initializationSettingAndroid,
      iOS: initializationSettingsIOS,
      macOS: null);
  flutterLocalNotificationsPlugin.initialize(intializationSetting);
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
}
