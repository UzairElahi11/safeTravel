import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/introduction/intro.dart';
import 'package:safe/screens/controllers/introduction/intro_viewModel.dart';
import 'package:safe/widgets/generic_drop_down.dart';
import 'package:safe/widgets/generic_svg_image.dart';
import 'package:safe/widgets/generic_text.dart';
import 'package:stacked/stacked.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_images_path.dart';
import '../../../Utils/app_text_styles.dart';
import '../../../Utils/app_util.dart';
import '../../../constants/all_texts.dart';
import '../../../widgets/generic_button.dart';

class Welcome extends StatelessWidget {
  static const id = "/Welcome";
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<IntroViewModel>.reactive(
        viewModelBuilder: () => IntroViewModel(),
        builder: (BuildContext context, IntroViewModel model, Widget? child) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: GenericSvgImage(
                  svgPath: AppImages.logoSvgImage,
                )),
                SizedBox(
                  height: 80.h,
                ),
                GenericText(
                  welcomeMessage,
                  style: AppStyles.bold28,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GenericText(
                  welcomeScreenDetailsText,
                  style: AppStyles.medium18,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 200.w),
                  child: GenericDropDown(
                      dropDownColor: AppColors.whiteColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColors.baseColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              BorderSide(width: 2, color: AppColors.baseColor),
                        ),
                      ),
                      useTransparentBorder: false,
                      borderColor: AppColors.baseColor,
                      items: model.languages,
                      hintText: drpLanguageHintText,
                      hintTextStyle: AppStyles.mediumBase20,
                      textStyle: AppStyles.mediumBase20,
                      textColor: AppColors.baseColor,
                      hintColor: AppColors.baseColor,
                      iconColor: AppColors.baseColor,
                      mapDropDownText: (option) => GenericText(option),
                      onDropDownItemChanged: (option) {
                        // if (option == 'English') {
                        //   context.setLocale(const Locale('en'));
                        // } else {
                        context.setLocale(const Locale('es'));
                        // }
                        log("option selection is $option");
                      },
                      fillColor: AppColors.whiteColor),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 200.w),
                    child: GenericButton(
                      height: 70.h,
                      width: double.infinity,
                      onPressed: () {
                        AppUtil.pushRoute(
                          context: context,
                          route: const IntroView(),
                        );
                      },
                      child: GenericText(
                        LocaleKeys.btnNextText,
                        style: AppStyles.medium20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
