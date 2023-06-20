import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe/Utils/app_colors.dart';
import 'package:safe/Utils/extensions/fonts.dart';

class AppStyles extends GoogleFonts {
  static var bold28 = Fonts.fonts(
    fontWeight: FontWeight.w800,
    fontSize: 28,
  );

  static var medium18 = Fonts.fonts(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  static var medium20 = Fonts.fonts(
      fontWeight: FontWeight.w400, fontSize: 20, color: AppColors.whiteColor);

  static var mediumBase20 = Fonts.fonts(
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: AppColors.baseColor,
  );

  static var medium24 = Fonts.fonts(
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: AppColors.blackColor,
  );

  static var bold29 = Fonts.fonts(
    fontWeight: FontWeight.w700,
    fontSize: 29,
    color: AppColors.blackColor,
  );

  static var medium14 = Fonts.fonts(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.editTextColor,
  );

  static var mediumBold16 = Fonts.fonts(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static var small12 = Fonts.fonts(
      fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.blackColor);
}
