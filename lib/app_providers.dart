import 'package:provider/provider.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:safe/screens/controllers/introduction/into_viewmodel.dart';
import 'package:safe/screens/controllers/login/login_viewmodel.dart';

class AppProviders {
  final List<ChangeNotifierProvider> appProviders = [
    // ============== SPLASH =================
    ChangeNotifierProvider<LoginViewModel>(
      create: (_) => LoginViewModel(),
    ),

    ChangeNotifierProvider<IntroViewModel>(
      create: (context) => IntroViewModel(),
    ),

    ChangeNotifierProvider<DisabilityViewModel>(
      create: (context) => DisabilityViewModel(),
    ),

    ChangeNotifierProvider<CalendarViewModel>(
      create: (context) => CalendarViewModel(),
    ),
  ];
}
