import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oyato_food/app/data/app_colors.dart';

class AppTextStyle {
  static final textStyle26SecondaryW500 = GoogleFonts.inter(
    color: AppColors.secondaryColor,
    fontSize: 26,
    fontWeight: FontWeight.w500,
  );
  static final textStyle16WhiteW500 = GoogleFonts.inter(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final textStyle14GreyW500 = GoogleFonts.inter(
    color: Colors.grey,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final textStyle26BlackBold = GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
  static final textStyle14BlackBold = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );
}