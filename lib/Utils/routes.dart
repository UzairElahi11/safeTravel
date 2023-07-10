import 'package:flutter/material.dart';
import 'package:safe/screens/UI/add_family_members/add_family_members.dart';
import 'package:safe/screens/UI/calendar/calendar.dart';
import 'package:safe/screens/UI/disablity/disablity.dart';
import 'package:safe/screens/UI/editForm/editFormView.dart';
import 'package:safe/screens/UI/splash/splash.dart';
import 'package:safe/screens/UI/user_details/userDetails.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Splash.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Splash(),
        );

      case Disability.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Disability(
            isFromLogin: true,
            body: {},
          ),
        );
      case Calendar.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const Calendar(
            body: {},
          ),
        );
      case UserDetailsView.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const UserDetailsView(
            isFromLogin: true,
          ),
        );
      case AddFamilyMembers.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AddFamilyMembers(body: {}),
        );

      // case LoginView.id:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => const LoginView());

      // case MainScreen.id:
      //   return MaterialPageRoute(
      //       settings: settings, builder: (_) => MainScreen());

      case ProfileView.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProfileView(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(child: Text("No route for ${settings.name}")),
          ),
        );
    }
  }
}
