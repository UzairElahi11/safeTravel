import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_images_path.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/app_util.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/disability_widgets/emergency_card.dart';

class Disability extends StatelessWidget {
  static const id = "DISABILITY_SCREEN";
  final bool isFromLogin;
  final Map<String, dynamic> body;
  const Disability({super.key, required this.isFromLogin, required this.body});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DisabilityViewModel(),
      builder: (context, model, _) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 60.w),
              child: ListView(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  // headerWidgetTop(context),
                  SizedBox(
                    height: 30.h,
                  ),
                  // GenericText(
                  //   LocaleKeys.disability,
                  //   style: AppStyles.medium24.copyWith(
                  //     fontWeight: FontWeight.w600,
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // DisabilityTypesCard(
                  //   model: model,
                  // ),
                  SizedBox(
                    height: 30.h,
                  ),
                  isFromLogin
                      ? GenericText(
                          "Emergency Contact",
                          style: AppStyles.medium24.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : const SizedBox(),
                  isFromLogin
                      ? SizedBox(
                          height: 15.h,
                        )
                      : const SizedBox(),
                  isFromLogin
                      ? EmergencyContactCard(model: model)
                      : const SizedBox(),
                  SizedBox(
                    height: 30.h,
                  ),
                  GenericButton(
                    height: 70.h,
                    width: double.infinity,
                    text: LocaleKeys.next.translatedString(),
                    textStyle: AppStyles.mediumBold16.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                    ),
                    onPressed: () => model.navigate(context, body),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
}
