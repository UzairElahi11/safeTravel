import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_text_styles.dart';
import 'package:safe/Utils/extensions/string.extension.dart';
import 'package:safe/Utils/generics/generic_text.dart';
import 'package:safe/screens/UI/user_details/userDetail_viewModel.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Utils/app_colors.dart';
import '../../l10n/locale_keys.g.dart';
import '../../Utils/generics/generic_button.dart';
import '../../Utils/generics/generic_text_field.dart';

class UserInformationDtails extends StatelessWidget {
  final UserDetailsViewModel model;
  const UserInformationDtails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GenericText(
            LocaleKeys.firstName.translatedString(),
            style: AppStyles.medium14.copyWith(color: AppColors.blackColor),
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
            fillColor: AppColors.containerBgColor,
            controller: model.firstNameController,
            borderRadius: 12.h,
            textColor: AppColors.editTextColor,
            filled: true,
            textInputType: TextInputType.text,
            errorText: model.firstnameError,
            hintText: LocaleKeys.hintFirstName.translatedString(),
          ),
          SizedBox(
            height: 20.h,
          ),
          GenericText(
            LocaleKeys.lastName.translatedString(),
            style: AppStyles.medium14.copyWith(color: AppColors.blackColor),
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
            fillColor: AppColors.containerBgColor,
            controller: model.lastNameController,
            borderRadius: 12.h,
            textColor: AppColors.editTextColor,
            filled: true,
            textInputType: TextInputType.text,
            errorText: model.lastNameLastError,
            hintText: LocaleKeys.hintLastName.translatedString(),
          ),
          SizedBox(
            height: 12.h,
          ),
          GenericText(
            LocaleKeys.dateOfBirth.translatedString(),
            style: AppStyles.medium14.copyWith(color: AppColors.blackColor),
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
            fillColor: AppColors.containerBgColor,
            controller: model.dateOfBirthController,
            borderRadius: 12.h,
            textColor: AppColors.editTextColor,
            filled: true,
            textInputType: TextInputType.text,
            errorText: model.dateofBirthError,
            hintText: LocaleKeys.dateOfBirth.translatedString(),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Container(
                height: 75.h,
                width: 75.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black12)),
                child: Center(
                  child: model.image == null
                      ? const Icon(Icons.person)
                      : Image.file(
                          model.image!,
                          width: 200,
                          height: 200,
                        ),
                ),
              ),
              GenericButton(
                onPressed: () async {
                  await model.selectImage();
                },
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                borderRadius: 8,
                height: 50.h,
                width: 150.h,
                text: "Upload",
                textStyle: TextStyle(color: AppColors.whiteColor),
                leading: Icon(
                  Icons.upload_file,
                  color: AppColors.whiteColor,
                ),
              ).px12(),
            ],
          ),
        ],
      ),
    );
  }
}
