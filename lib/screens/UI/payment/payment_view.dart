import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/Utils/generics/generic_text_field.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/payment/cardFormatter/monthFormatter.dart';
import 'package:safe/screens/UI/payment/payment_viewModel.dart';
import 'package:stacked/stacked.dart';

import 'cardFormatter/cardNumberFormatter.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100.w),
          child: ViewModelBuilder<PaymentViewModel>.reactive(
            onViewModelReady: (model) {
              // model.checkingEmailText();
            },
            viewModelBuilder: () => PaymentViewModel(),
            builder: (context, model, _) {
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                        child: GenericText(
                          LocaleKeys.paymentHeader,
                          style: AppStyles.medium24.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const GenericText(
                        LocaleKeys.paymentDescription,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        // textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration:
                            BoxDecoration(color: AppColors.containerBgColor),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GenericText(
                                  LocaleKeys.price,
                                  style: TextStyle(
                                      color: AppColors.color232323,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                GenericText(
                                  "\$344",
                                  style: TextStyle(
                                      color: AppColors.color5E5D5D,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GenericText(
                                  LocaleKeys.tax,
                                  style: TextStyle(
                                      color: AppColors.color232323,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                GenericText(
                                  "\$4.00",
                                  style: TextStyle(
                                      color: AppColors.color5E5D5D,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GenericText(
                                  LocaleKeys.familyRate,
                                  style: TextStyle(
                                      color: AppColors.color232323,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                GenericText(
                                  "\$344",
                                  style: TextStyle(
                                      color: AppColors.color5E5D5D,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      const GenericText(
                        LocaleKeys.paymentDescription,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        // textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GenericText(
                        LocaleKeys.cardNumber,
                        style: TextStyle(
                            color: AppColors.color232323,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GenericTextField(
                        controller: model.cardNumberController,
                        fillColor: AppColors.containerBgColor,
                        filled: true,
                        errorText: model.cardNumberValidator,
                        hintText: LocaleKeys.cardNumber.translatedString(),
                        textAlign: TextAlign.center,
                        isNumberField: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                          CardNumberInputFormatter()
                        ],
                        // contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GenericText(
                                  "CVV",
                                  style: TextStyle(
                                      color: AppColors.color232323,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GenericTextField(
                                  controller: model.cardNumberController,
                                  fillColor: AppColors.containerBgColor,
                                  filled: true,
                                  isNumberField: true,
                                  hintText: "123",
                                  errorText: model.cvvValidator,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    // Limit the input
                                    LengthLimitingTextInputFormatter(4),
                                  ],
                                  // contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GenericText(
                                  "Expiry Date",
                                  style: TextStyle(
                                      color: AppColors.color232323,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                GenericTextField(
                                  controller: model.expController,
                                  fillColor: AppColors.containerBgColor,
                                  filled: true,
                                  isNumberField: true,
                                  errorText: model.expValidator,
                                  hintText: "12/23",
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(4),
                                    CardMonthInputFormatter(),
                                  ],
                                  // contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      GenericButton(
                        height: 70.h,
                        onPressed: () {
                          model.validator(context);
                        },
                        text: LocaleKeys.next,
                        textStyle: AppStyles.mediumBold16.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
