import 'package:safe/app_providers.dart';

import 'Utils/validator/textformfield_validation.dart';
import 'Utils/validator/textformfield_validator.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.I;
Future<void> initializeDependencies() async {
  locator.registerFactory<TextFieldValidator>(
    () => TextFieldValidatorImpl(),
  );

  locator.registerFactory<AppProviders>(
    () => AppProviders(),
  );
}
