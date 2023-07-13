import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/screens/UI/disablity/disability_viewmodel.dart';
import 'package:safe/Utils/generics/generic_text.dart';

import '../../Utils/app_colors.dart';
import '../../l10n/locale_keys.g.dart';
import '../../Utils/generics/generic_text_field.dart';

class EmergencyContactCard extends StatelessWidget {
  final DisabilityViewModel model;
  const EmergencyContactCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.containerBgColor,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GenericText(
              LocaleKeys.name.translatedString(),
              style: AppStyles.medium14
                  .copyWith(color: AppColors.mediumBlackColor),
            ),
            SizedBox(
              height: 12.h,
            ),
            GenericTextField(
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
              hintStyle: AppStyles.small12.copyWith(
                color: AppColors.editTextColor,
                fontWeight: FontWeight.w400,
              ),
              prefixPadding: EdgeInsets.symmetric(horizontal: 20.w),
              fillColor: AppColors.whiteColor,
              controller:nameController,
              borderRadius: 12.h,
              textColor: AppColors.editTextColor,
              filled: true,
              textInputType: TextInputType.text,
              errorText: model.nameError,
              hintText: LocaleKeys.addName.translatedString(),
            ),
            SizedBox(
              height: 20.h,
            ),
            GenericText(
              LocaleKeys.phoneNumber.translatedString(),
              style: AppStyles.medium14
                  .copyWith(color: AppColors.mediumBlackColor),
            ),
            SizedBox(
              height: 12.h,
            ),
            GenericTextField(
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
              hintStyle: AppStyles.small12.copyWith(
                color: AppColors.editTextColor,
                fontWeight: FontWeight.w400,
              ),
              prefixPadding: EdgeInsets.symmetric(horizontal: 20.w),
              fillColor: AppColors.whiteColor,
              controller: phoneNumberController,
              borderRadius: 12.h,
              textColor: AppColors.editTextColor,
              filled: true,
              textInputType: TextInputType.text,
              errorText: model.phoneError,
              hintText: LocaleKeys.addNumber.translatedString(),
            ),
            SizedBox(
              height: 20.h,
            ),
            GenericText(
              LocaleKeys.addNotes.translatedString(),
              style: AppStyles.medium14
                  .copyWith(color: AppColors.mediumBlackColor),
            ),
            SizedBox(
              height: 12.h,
            ),
            GenericTextField(
              textInputType: TextInputType.multiline,
              expanded: false,
              maxLength: null,
              maxLines: 10,
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
              hintStyle: AppStyles.small12.copyWith(
                color: AppColors.editTextColor,
                fontWeight: FontWeight.w400,
              ),
              prefixPadding: EdgeInsets.symmetric(horizontal: 20.w),
              fillColor: AppColors.whiteColor,
              controller:notesController,
              borderRadius: 12.h,
              textColor: AppColors.editTextColor,
              filled: true,
              errorText: model.notesError,
              hintText: LocaleKeys.addNotes.translatedString(),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
            //   child: GenericButton(
            //     width: 500.w,
            //     padding: EdgeInsets.zero,
            //     onPressed: () {},
            //     leading: GenericIcon(
            //       icon: Icons.add,
            //       color: AppColors.whiteColor,
            //     ),
            //     text: LocaleKeys.add.translatedString(),
            //     borderRadius: 10,
            //     textStyle: AppStyles.medium14.copyWith(
            //       fontWeight: FontWeight.w600,
            //       color: AppColors.whiteColor,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
