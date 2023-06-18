import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/login/login.dart';
import 'package:safe/screens/controllers/registration/registration_viewModel.dart';
import 'package:safe/widgets/generic_button.dart';
import 'package:safe/widgets/generic_icon.dart';
import 'package:safe/widgets/generic_text.dart';
import 'package:safe/widgets/generic_text_field.dart';
import 'package:stacked/stacked.dart';

import '../../../Utils/app_images_path.dart';

class RegistationView extends StatelessWidget {
  static const id = "/RegistationView";
  const RegistationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<RegistrationViewModel>.reactive(
        viewModelBuilder: () => RegistrationViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.init();
        },
        builder:
            (BuildContext context, RegistrationViewModel model, Widget? child) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(left: 34.h, right: 34.h, top: 100.h),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      headerWidgetTop(context),
                      SizedBox(
                        height: 20.h,
                      ),
                      headerWidget(),
                      SizedBox(
                        height: 20.h,
                      ),
                      GenericText(
                        LocaleKeys.register,
                        style: AppStyles.medium18
                            .copyWith(color: AppColors.baseColor),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, top: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            const GenericText(LocaleKeys.full_name),
                            SizedBox(
                              height: 10.h,
                            ),
                            //full name
                            GenericTextField(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 30.h),
                              hintStyle: AppStyles.medium14,
                              prefixPadding:
                                  EdgeInsets.symmetric(horizontal: 70.w),
                              fillColor: AppColors.containerBgColor,
                              controller: model.fullName,
                              borderRadius: 12.h,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    AppUtil.spaceNotAllowedRegex),
                              ],
                              textColor: AppColors.editTextColor,
                              filled: true,
                              textInputType: TextInputType.text,
                              errorText: model.fullNameValidationError,
                              hintText: AppUtil.fullNameHint,
                              leadingIcon: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: Row(
                                  children: [
                                    GenericIcon(
                                      icon: Icons.person,
                                      color: AppColors.baseColor,
                                    ),
                                    SizedBox(
                                      width: 60.w,
                                    ),
                                    Container(
                                      height: 25.h,
                                      color: AppColors.dividerColor
                                          .withOpacity(0.6),
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const GenericText(LocaleKeys.full_name),
                            SizedBox(
                              height: 20.h,
                            ),
                            //email
                            GenericTextField(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 30.h),
                              hintStyle: AppStyles.medium14,
                              prefixPadding:
                                  EdgeInsets.symmetric(horizontal: 70.w),
                              fillColor: AppColors.containerBgColor,
                              controller: model.email,
                              borderRadius: 12.h,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    AppUtil.spaceNotAllowedRegex),
                              ],
                              textColor: AppColors.editTextColor,
                              filled: true,
                              textInputType: TextInputType.text,
                              errorText: model.emailValidationError,
                              hintText: AppUtil.emailHint,
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
                                      color: AppColors.dividerColor
                                          .withOpacity(0.6),
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const GenericText(LocaleKeys.password),
                            SizedBox(
                              height: 20.h,
                            ),
                            //password
                            GenericTextField(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 30.h),
                              hintStyle: AppStyles.medium14,
                              prefixPadding:
                                  EdgeInsets.symmetric(horizontal: 70.w),
                              fillColor: AppColors.containerBgColor,
                              controller: model.password,
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
                                      color: AppColors.dividerColor
                                          .withOpacity(0.6),
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            const GenericText(LocaleKeys.confirmPassword),
                            SizedBox(
                              height: 20.h,
                            ),
                            //confirm password
                            GenericTextField(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 30.h),
                              hintStyle: AppStyles.medium14,
                              prefixPadding:
                                  EdgeInsets.symmetric(horizontal: 70.w),
                              fillColor: AppColors.containerBgColor,
                              controller: model.confirmPassword,
                              borderRadius: 12.h,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    AppUtil.spaceNotAllowedRegex),
                              ],
                              textColor: AppColors.editTextColor,
                              filled: true,
                              textInputType: TextInputType.text,
                              errorText: model.confirmPasswordErrorValidator,
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
                                      color: AppColors.dividerColor
                                          .withOpacity(0.6),
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            button(model),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                AppUtil.pushRoute(
                                    context: context, route: const Login());
                              },
                              child: Center(
                                child: Text.rich(
                                  TextSpan(
                                      text: LocaleKeys.alreadyAccount.tr(),
                                      children: [
                                        TextSpan(
                                            text: LocaleKeys.loginText.tr(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                      ]),
                                ),
                              ),
                            ),

                            // emailContainer(),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget button(RegistrationViewModel model) {
    // return SizedBox(
    //   height: 50,
    //   width: double.infinity,
    //   child: ElevatedButton(
    //       onPressed: () {
    //         // AppUtil.pushRoute(
    //         //     context: context,
    //         //     route:  MainScreen());
    //       },
    //       style: ButtonStyle(
    //           backgroundColor:
    //               MaterialStateProperty.all<Color>(AppColors.baseColor),
    //           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    //               RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(18.0),
    //           ))),
    //       child: const Text(
    //         "Sign up",
    //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //       )),
    // );
    return GenericButton(
      height: 80.h,
      width: double.infinity,
      color: AppColors.baseColor,
      child: GenericText(
        LocaleKeys.signUpButtonText,
        style: AppStyles.mediumBold16.copyWith(color: AppColors.whiteColor),
      ),
      onPressed: () => model.validate(),
    );
  }

  Widget headerWidgetTop(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisAlignment: Mai,
      children: [
        InkWell(
            onTap: () {
              AppUtil.pop(context: context);
            },
            child: SvgPicture.asset(AppImages.backArrow)),
        SizedBox(
          width: 100.h,
        ),
      ],
    );
  }

  Widget emailContainer() {
    return Center(
        child: Text(
      "info@staysafemorocco.com",
      style: TextStyle(
        color: AppColors.lightGreyColor,
        decoration: TextDecoration.underline,
      ),
    ));
  }

  Widget headerWidget() {
    return const Center(
        child: Text(
      "Stay Safe Morocco",
      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    ));
  }
}
