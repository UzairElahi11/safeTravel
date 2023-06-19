import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/l10n/locale_keys.g.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_text_styles.dart';
import '../generic_button.dart';
import '../generic_check_box.dart';
import '../generic_icon.dart';
import '../generic_text.dart';

class DisabilityTypesCard extends StatelessWidget {
  final DisabilityViewModel model;
  const DisabilityTypesCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.containerBgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            shrinkWrap: true,
            itemCount: model.disabilityTypes.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 16 / 4, crossAxisCount: 2),
            itemBuilder: (context, index) => Row(
              children: [
                GenericCheckBox(
                  visualDensity: VisualDensity.compact,
                  value: model.disabilityTypes[index]["isChecked"],
                  onChanged: (value) {
                    model.changeCheckBoxvalue(index);
                  },
                ),
                SizedBox(width: 10.w),
                GenericText(
                  model.disabilityTypes[index]["name"],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: GenericButton(
              width: 400.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              onPressed: () {},
              leading: GenericIcon(
                icon: Icons.add,
                color: AppColors.whiteColor,
              ),
              text: LocaleKeys.add.translatedString(),
              borderRadius: 10,
              textStyle: AppStyles.medium14.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColor,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
