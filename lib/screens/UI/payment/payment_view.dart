import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/Utils/generics/generic_text_field.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/payment/cardFormatter/monthFormatter.dart';
import 'package:safe/screens/UI/payment/payment_viewModel.dart';
import 'package:safe/screens/UI/payment/payment_webView.dart';
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
              model.init(context);
            },
            viewModelBuilder: () => PaymentViewModel(),
            builder: (context, model, _) {
              return WillPopScope(
                onWillPop: () async => false,
                child: SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GenericText(
                                    LocaleKeys.price,
                                    style: TextStyle(
                                        color: AppColors.color232323,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GenericText(
                                    "\$${model.price}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GenericText(
                                    LocaleKeys.tax,
                                    style: TextStyle(
                                        color: AppColors.color232323,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GenericText(
                                    model.tax,
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
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     GenericText(
                              //       LocaleKeys.familyRate,
                              //       style: TextStyle(
                              //           color: AppColors.color232323,
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w500),
                              //     ),
                              //     GenericText(
                              //       "\$${model.priceAfterText}",
                              //       style: TextStyle(
                              //           color: AppColors.color5E5D5D,
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w400),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 20.h,
                              // ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GenericText(
                                    LocaleKeys.discount,
                                    style: TextStyle(
                                        color: AppColors.color232323,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  GenericText(
                                    "\$${model.discount}",
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
                          LocaleKeys.applyReferal,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          // textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GenericTextField(
                                controller: model.referalCodeController,
                                fillColor: AppColors.containerBgColor,
                                filled: true,
                                hintText:
                                    LocaleKeys.enterCode.translatedString(),
                                textAlign: TextAlign.center,
                                isNumberField: false,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.h,
                            ),
                            Expanded(
                                child: GenericButton(
                              padding: const EdgeInsets.all(10),
                              onPressed: () {
                                model.couponValidate(
                                  codee: model.referalCodeController.text,
                                  context: context,
                                  completion: (success) {
                                    model.coupon =
                                        model.referalCodeController.text.trim();
                                  },
                                );
                              },
                              text: "Apply",
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ))
                          ],
                        ),
                       
                        SizedBox(
                          height: 100.h,
                        ),
                        GenericButton(
                          height: 70.h,
                          onPressed: () {
                            // model.validator(context);
                             AppUtil.pushRoute(context: context,route: PaymentWebview(url: model.url??""));
                           

                          },
                          text: "Pay Now",
                          textStyle: AppStyles.mediumBold16.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GenericButton(
                          height: 70.h,
                          onPressed: () async => model.skipSaveLocally(),
                          text: LocaleKeys.skip,
                          textStyle: AppStyles.mediumBold16.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
