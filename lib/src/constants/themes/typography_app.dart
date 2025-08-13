import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calisfun/src/constants/constants.dart';

class TypographyApp {
  static TextStyle get headingSmallRegular => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorApp.mainBlack,
  );

  static TextStyle get headingSmallMedium => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorApp.mainBlack,
  );

  static TextStyle get headingSmallBold => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ColorApp.mainBlack,
  );

  static TextStyle get headingLargeRegular => GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: ColorApp.mainBlack,
  );

  static TextStyle get headingLargeMedium => GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: ColorApp.mainBlack,
  );

  static TextStyle get headingLargeBold => GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: ColorApp.mainBlack,
  );

  static TextStyle get headingLargeBoldPrimary => GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    color: ColorApp.primary,
  );

  static TextStyle get bodyNormalRegular => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorApp.mainBlack,
  );

  static TextStyle get bodyNormalMedium => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorApp.mainBlack,
  );

  static TextStyle get bodyNormalBold => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: ColorApp.mainBlack,
  );

  static TextStyle get labelSmallRegular => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: ColorApp.mainBlack,
  );

  static TextStyle get labelSmallMedium => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: ColorApp.mainBlack,
  );

  static TextStyle get labelSmallMediumGrey => GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: ColorApp.label,
  );

  static TextStyle get labelSmallBold => GoogleFonts.poppins(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: ColorApp.mainBlack,
  );
}