import 'package:provider/provider.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';
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
  ];
}
