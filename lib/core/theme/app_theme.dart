import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servi_go_app/core/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(),
    colorScheme: ThemeData.light().colorScheme.copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.grey,
    ),
    primaryColor: AppColors.primaryColor,
    cardColor: Colors.white,
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    colorScheme: ThemeData.dark().colorScheme.copyWith(
      primary: AppColors.primaryColor,
      secondary: AppColors.grey,
    ),
    primaryColor: AppColors.primaryColor,
    cardColor: const Color(0xFF1E1E1E),
  );
}
