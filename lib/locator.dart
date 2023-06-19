import 'package:get_it/get_it.dart';
import 'package:safe/Utils/local_storage.dart';
import 'package:safe/app_providers.dart';

import 'Utils/validator/textformfield_validation.dart';
import 'Utils/validator/textformfield_validator.dart';

final locator = GetIt.I;
Future<void> initializeDependencies() async {
  locator.registerFactory<TextFieldValidator>(
    () => TextFieldValidatorImpl(),
  );

  locator.registerFactory<AppProviders>(
    () => AppProviders(),
  );

  ///We will register this to make the local storage object singleton
  ///so that it will only make one object in the application and will accessible
  ///to anywhere in the application.It will only create object will it is needed
  locator.registerLazySingleton<LocalSecureStorage>(
    () => LocalSecureStorage(),
  );


}
