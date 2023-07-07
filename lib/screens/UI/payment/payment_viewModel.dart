import 'package:flutter/material.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/carValidation.dart';

class PaymentViewModel with ChangeNotifier {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expController = TextEditingController();
  String? cardNumberValidator;
  String? cvvValidator;
  String? expValidator;

  validator(BuildContext context) {
    expValidator = CardUtils.validateDate(expController.text);
    cardNumberValidator = CardUtils.validateCardNum(cardNumberController.text);
    cvvValidator = CardUtils.validateCVV(cvvController.text);
    if (expValidator == null &&
        expValidator!.isEmpty &&
        cvvValidator == null &&
        expValidator!.isEmpty &&
        expValidator == null &&
        expValidator!.isEmpty) {
       AppUtil.pushRoute(context: context, route:const DashboardView());
    }

    notifyListeners();
  }
}
