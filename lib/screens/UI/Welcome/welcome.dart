import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/introduction/intro.dart';
import 'package:safe/screens/controllers/introduction/into_viewmodel.dart';
import 'package:safe/Utils/generics/generic_drop_down.dart';
import 'package:safe/Utils/generics/generic_svg_image.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:stacked/stacked.dart';

import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/locale.dart';
import 'package:safe/Utils/generics/generic_button.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  LocaleKeys.welcomeMessage,
                  style: AppStyles.bold28,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GenericText(
                  LocaleKeys.welcomeScreenDetailsText,
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
                      items: model.enLanguages,
                      hintText: LocaleKeys.drpLanguageHintText.tr(),
                      hintTextStyle: AppStyles.mediumBase20,
                      textStyle: AppStyles.mediumBase20,
                      textColor: AppColors.baseColor,
                      hintColor: AppColors.baseColor,
                      iconColor: AppColors.baseColor,
                      mapDropDownText: (option) => GenericText(option),
                      onDropDownItemChanged: (option) async {
                        if (model.language[0] == option) {
                          context.setLocale(
                            L10n.all[0],
                          );

                          await model.storeLocaleLanguageCode(option ?? "");
                        } else {
                          context.setLocale(
                            L10n.all[1],
                          );

                          await model.storeLocaleLanguageCode(option ?? "");
                        }
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
