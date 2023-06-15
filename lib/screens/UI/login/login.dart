import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/constants/all_texts.dart';
import 'package:safe/screens/controllers/login/login_viewmodel.dart';
import 'package:safe/widgets/generic_button.dart';
import 'package:safe/widgets/generic_icon.dart';
import 'package:safe/widgets/generic_svg_image.dart';
import 'package:safe/widgets/generic_text.dart';
import 'package:safe/widgets/generic_text_field.dart';
import 'package:stacked/stacked.dart';

import '../../../Utils/app_images_path.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ViewModelBuilder<LoginViewModel>.reactive(
          onViewModelReady: (model) => model.checkingEmailText(),
          viewModelBuilder: () => LoginViewModel(),
          builder: (context, model, _) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                    ),
                    GenericText(
                      welcomeText,
                      style: AppStyles.medium24,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GenericText(
                      staySafeText,
                      style: AppStyles.bold29,
                    ),
                    SizedBox(
                      height: 28.h,
                    ),
                    GenericText(
                      loginText,
                      style: AppStyles.mediumBase20.copyWith(
                        color: AppColors.baseColor,
                      ),
                    ),
                    SizedBox(
                      height: 34.h,
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
                        loginText,
                        style: AppStyles.mediumBold16
                            .copyWith(color: AppColors.whiteColor),
                      ),
                      onPressed: () => model.validate(),
                    ),
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
                        //TODO: Have to implement the google sigin on this button
                      },
                    ),
                    SizedBox(
                      height: 50.h,
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
                            continueText,
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
                      height: 50.h,
                    ),
                    Row(
                      children: [
                        GenericSvgImage(
                          svgPath: AppImages.facebookSvgIcon,
                          height: 24.h,
                          width: 24.w,
                        ),
                        GenericSvgImage(
                          height: 24.h,
                          width: 24.w,
                          svgPath: AppImages.appleSvgIcon,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    GenericText(
                      contactInfoText,
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