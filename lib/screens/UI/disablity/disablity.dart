import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:safe/Utils/generics/generic_button.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/disability_widgets/disability_types_card.dart';
import '../../../widgets/disability_widgets/emergency_card.dart';

class Disability extends StatelessWidget {
  static const id = "DISABILITY_SCREEN";
  const Disability({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => DisabilityViewModel(),
      builder: (context, model, _) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: ListView(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                GenericText(
                  LocaleKeys.disability,
                  style: AppStyles.medium24.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DisabilityTypesCard(
                  model: model,
                ),
                SizedBox(
                  height: 30.h,
                ),
                EmergencyContactCard(model: model),
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
                  onPressed: () => model.navigate(context),
                ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
