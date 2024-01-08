import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webskitters_assignment/utils/app_colors.dart';
import 'package:webskitters_assignment/utils/size_utils.dart';

class AppTextStyle {
  static TextStyle headingTextStyle = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18);

  static TextStyle regular400() {
    return GoogleFonts.poppins(
        color: AppColors.seaweed,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal);
  }

  static TextStyle regular400Italic() {
    return GoogleFonts.poppins(
        color: AppColors.seaweed,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic);
  }

  static TextStyle medium500() {
    return GoogleFonts.poppins(
        color: AppColors.seaweed,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal);
  }

  static TextStyle semiBold600() {
    return GoogleFonts.poppins(
        color: AppColors.seaweed,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal);
  }

  static TextStyle bold700() {
    return GoogleFonts.poppins(
        color: AppColors.seaweed,
        fontSize: 10.fSize,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal);
  }

  static TextStyle textInputStyle({Color? color}) {
    return TextStyle(
      color: Color.fromARGB(255, 243, 241, 240),
      fontSize: 16.fSize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textInputErrorStyle({Color? color}) {
    return TextStyle(
      color: AppColors.lava,
      fontSize: 16.fSize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textPageTitleStyle() {
    return const TextStyle(
      color: Color.fromARGB(255, 242, 238, 236),
      fontSize: 22,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textPageSubTitleStyle() {
    return const TextStyle(
      color: Color.fromARGB(127, 242, 238, 236),
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textParagraphStyle() {
    return const TextStyle(
      color: AppColors.lava,
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
  }
}
