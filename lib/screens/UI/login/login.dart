import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/dashboard/dashboard.dart';
import 'package:safe/screens/UI/payment/payment_view.dart';
import 'package:safe/screens/UI/registration/registration_view.dart';
import 'package:safe/screens/UI/user_details/userDetails.dart';
import 'package:safe/screens/controllers/login/login_viewmodel.dart';
import 'package:safe/Utils/generics/generic_asset_image.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_icon.dart';
import 'package:safe/Utils/generics/generic_svg_image.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/Utils/generics/generic_text_field.dart';
import 'package:stacked/stacked.dart';
import 'package:safe/Utils/app_images_path.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ViewModelBuilder<LoginViewModel>.reactive(
          onViewModelReady: (model) {
            model.checkingEmailText();
          },
          viewModelBuilder: () => LoginViewModel(),
          builder: (context, model, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    GenericText(
                      LocaleKeys.staySafe,
                      style: AppStyles.bold29,
                      textAlign: TextAlign.center,
                    ),
                    // SizedBox(
                    //   height: 10.h,
                    // ),
                    // GenericText(
                    //   LocaleKeys.staySafeText,
                    //   style: AppStyles.bold29,
                    // ),
                    // SizedBox(
                    //   height: 28.h,
                    // ),
                    // GenericText(
                    //   LocaleKeys.loginText,
                    //   style: AppStyles.mediumBase20.copyWith(
                    //     color: AppColors.baseColor,
                    //   ),
                    // ),
                    SizedBox(
                      height: 50.h,
                    ),
                    GenericTextField(
                      contentPadding: EdgeInsets.symmetric(vertical: 30.h),
                      hintStyle: AppStyles.medium14,
                      prefixPadding: EdgeInsets.symmetric(horizontal: 70.w),
                      fillColor: AppColors.containerBgColor,
                      controller: model.emailController,
                      borderRadius: 12.h,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(
                            AppUtil.spaceNotAllowedRegex),
                      ],
                      textColor: AppColors.editTextColor,
                      filled: true,
                      textInputType: TextInputType.text,
                      errorText: model.emailValidationError,
                      hintText: LocaleKeys.email.translatedString(),
                      leadingIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Row(
                          children: [
                            GenericIcon(
                              icon: Icons.email_rounded,
                              color: AppColors.baseColor,
                            ),
                            SizedBox(
                              width: 60.w,
                            ),
                            Container(
                              height: 25.h,
                              color: AppColors.dividerColor.withOpacity(0.6),
                              width: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    ValueListenableBuilder(
                        valueListenable: model.showPassword,
                        builder: (context, password, _) {
                          return GenericTextField(
                            isObscure: password ? true : false,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 30.h),
                            hintStyle: AppStyles.medium14,
                            prefixPadding:
                                EdgeInsets.symmetric(horizontal: 70.w),
                            trailingPadding:
                                EdgeInsets.symmetric(horizontal: 70.w),
                            fillColor: AppColors.containerBgColor,
                            controller: model.passwordController,
                            borderRadius: 12.h,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  AppUtil.spaceNotAllowedRegex),
                            ],
                            textColor: AppColors.editTextColor,
                            filled: true,
                            textInputType: TextInputType.text,
                            errorText: model.passwordValidationError,
                            hintText: AppUtil.hintPassword,
                            leadingIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              child: Row(
                                children: [
                                  GenericIcon(
                                    icon: Icons.lock,
                                    color: AppColors.baseColor,
                                  ),
                                  SizedBox(
                                    width: 60.w,
                                  ),
                                  Container(
                                    height: 25.h,
                                    color:
                                        AppColors.dividerColor.withOpacity(0.6),
                                    width: 2,
                                  ),
                                ],
                              ),
                            ),
                            trailingIcon: GestureDetector(
                              onTap: () => model.visiblePassFunc(),
                              child: GenericSvgImage(
                                svgPath: AppImages.passwordSvgIcon,
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 60.h,
                    ),
                    GenericButton(
                        height: 80.h,
                        width: double.infinity,
                        color: AppColors.baseColor,
                        child: GenericText(
                          LocaleKeys.loginText,
                          style: AppStyles.mediumBold16
                              .copyWith(color: AppColors.whiteColor),
                        ),
                        onPressed: () {
                          if (model.validate()) {
                            model.login(
                                email: model.emailController.text,
                                context: context,
                                password: model.passwordController.text,
                                completion: (check, form, isPayment) {
                                  model.showToaster(context);
                                  if (check) {
                                    if (form == 1 && isPayment == 1) {
                                      AppUtil.pushRoute(
                                        pushReplacement: true,
                                        context: context,
                                        route: const DashboardView(),
                                      );
                                    } else if (form == 1 && isPayment == 0) {
                                      AppUtil.pushRoute(
                                        pushReplacement: true,
                                        context: context,
                                        route: const PaymentView(),
                                      );
                                    } else {
                                      AppUtil.pushRoute(
                                        pushReplacement: true,
                                        context: context,
                                        route: const UserDetailsView(
                                          isFromLogin: true,
                                        ),
                                      );
                                    }
                                  }
                                });
                          }
                        }),
                    SizedBox(
                      height: 20.h,
                    ),
                    GenericButton(
                      borderColor: AppColors.baseColor,
                      borderWidth: 1.5,
                      height: 80.h,
                      width: double.infinity,
                      color: AppColors.transparentColor,
                      child: Center(
                        child: GenericSvgImage(
                          svgPath: AppImages.googleSvgIcon,
                        ),
                      ),
                      onPressed: () {
                        model.googleLogin();
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      onTap: () {
                        AppUtil.pushRoute(
                            context: context, route: const RegistationView());
                      },
                      child: const Text.rich(
                        TextSpan(text: 'Have no account? ', children: [
                          TextSpan(
                              text: 'Create now',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              )),
                        ]),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.dividerColor,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60.0.w),
                          child: GenericText(
                            LocaleKeys.continueText,
                            style: AppStyles.small12,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.dividerColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => model.facebookLoginFunc(context),
                          child: Container(
                            height: 45,
                            width: 60,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1,
                                  color: AppColors.socailContainerBorderSide),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: GenericAssetImageWidget(
                              image: AppImages.facebookPngIcon,
                              // height: 80.h,
                              // width: 80.w,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.w,
                        ),
                        Visibility(
                          visible: Platform.isIOS ? true : false,
                          child: GestureDetector(
                            onTap: () => model.appleLogin(),
                            child: Container(
                              height: 45,
                              width: 60,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: AppColors.socailContainerBorderSide),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: GenericAssetImageWidget(
                                image: AppImages.applePngIcon,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GenericText(
                      LocaleKeys.contactInfoText,
                      style: AppStyles.medium18.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: model.textSpans,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
