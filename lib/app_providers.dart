import 'package:provider/provider.dart';
import 'package:safe/screens/UI/add_family_members/add_family_members_viewmodel.dart';
import 'package:safe/screens/UI/calendar/calendar_viewmodel.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:safe/screens/UI/user_details/userDetail_viewModel.dart';
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

     ChangeNotifierProvider<UserDetailsViewModel>(
      create: (context) => UserDetailsViewModel(),
    ),
    ChangeNotifierProvider<CalendarViewModel>(
      create: (context) => CalendarViewModel(),
    ),
     ChangeNotifierProvider<AddFamilyMembersViewModel>(
      create: (context) => AddFamilyMembersViewModel(),
    ),
  ];
}
