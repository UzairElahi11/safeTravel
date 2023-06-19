import 'package:flutter/widgets.dart';

class DisabilityViewModel extends ChangeNotifier {
  Map<String, bool> disabilityTypes = {};

  //Textediting controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  //validate the fields, should not empty while submitting the form
  bool validate() {
    return true;
  }
}
