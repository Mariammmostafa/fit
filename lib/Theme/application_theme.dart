import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationThemeManager {


   static Color PrimaryColor=const Color(0xFF39A552);

static ThemeData Lighttheme= ThemeData(
  primaryColor: const Color(0xFF39A552),

  appBarTheme: AppBarTheme(
   color: PrimaryColor,
  toolbarHeight: 75,
  elevation: 0,
  shape: const RoundedRectangleBorder(
   borderRadius: BorderRadius.only(
     bottomRight:  Radius.circular(25),
     bottomLeft:  Radius.circular(25),
   ),
  ),
   ),









  textTheme: TextTheme(

    titleLarge: GoogleFonts.almarai(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.white,

    ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      //  color: primaryColor,

      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1B5E20),

      ),
     bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color(0xFF1B5E20),

      ),
      bodySmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: Color(0xFF1B5E20),

      ),
  )
);



}