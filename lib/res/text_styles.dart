import 'package:google_fonts/google_fonts.dart';
import 'package:task/res/colors.dart';
import 'package:task/res/res.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  final kTextButton = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: sizes.mediumFontSize,
  ));
  final kTextButton1 = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: sizes.regularFontSize,
  ));
  final kTextTitle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.regularFontSize,
  ));
  final kTextSubtitle1 = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.mediumFontSize,
  ));
  final kHintStyle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.mediumFontSize,
    color: AppColors().kColorSubhead,
  ));
  final kLabelStyle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    // fontSize: sizes.smallFontSize,
    fontSize: sizes.mediumFontSize,
    color: AppColors().kColorSubhead,
  ));
  final kTextSubtitle2 = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.smallFontSize,
  ));
  final kTextSubtitle3 = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.smallFontSize,
  ));
  final kTextSubtitle4 = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.extraSmallFontSize,
  ));
  final kTextLogo = GoogleFonts.inter(
      textStyle: TextStyle(
          fontWeight: FontWeight.w700, fontSize: sizes.regularFontSize));

  final kTextLogoTwo = GoogleFonts.inter(
      textStyle: TextStyle(
          fontWeight: FontWeight.w400, fontSize: sizes.smallFontSize));
  final kTextAppBarTitle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: sizes.extraMediumFontSize,
  ));

  final kTextSubtitle1Bold = GoogleFonts.inter(
      textStyle: TextStyle(
          fontWeight: FontWeight.w700, fontSize: sizes.mediumFontSize));

  final kTextTabTitle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.regularFontSize,
  ));
  final kTextAppBarActionText = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: sizes.regularFontSize,
  ));
  final kTextSmallButton = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.regularFontSize,
  ));
  final kTextLink = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: sizes.smallFontSize,
    color: AppColors().kColorSubhead,
  ));
  final kTextHeadline = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: sizes.extraLargeFontSize,
  );
  final kTextSubHeadline = GoogleFonts.inter(
      textStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: sizes.mediumFontSize,
  ));
}
