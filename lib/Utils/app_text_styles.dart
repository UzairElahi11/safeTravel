import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe/Utils/extensions/fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:safe/Utils/app_colors.dart';

class AppStyles extends GoogleFonts {
  static var bold28 = Fonts.fonts(
    fontWeight: FontWeight.w800,
    fontSize: 28.sp,
  );

  static var medium18 = Fonts.fonts(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
  );

  static var medium20 = Fonts.fonts(
      fontWeight: FontWeight.w400,
      fontSize: 20.sp,
      color: AppColors.whiteColor);

  static var mediumBase20 = Fonts.fonts(
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
    color: AppColors.baseColor,
  );

  static var medium24 = Fonts.fonts(
    fontWeight: FontWeight.w500,
    fontSize: 24.sp,
    color: AppColors.blackColor,
  );

  static var bold29 = Fonts.fonts(
    fontWeight: FontWeight.w700,
    fontSize: 29.sp,
    color: AppColors.blackColor,
  );

  static var medium14 = Fonts.fonts(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: AppColors.editTextColor,
  );

  static var mediumBold16 = Fonts.fonts(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static var small12 = Fonts.fonts(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.blackColor);
}
