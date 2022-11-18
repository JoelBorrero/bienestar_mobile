import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color primaryColorDark = const Color(0xFF01007C),
    splashColor = const Color(0xFF00A1AB);

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFF0200AB),
  primaryColorDark: primaryColorDark,
  splashColor: splashColor,
  scaffoldBackgroundColor: const Color(0xFFEDF3FB),
  cardColor: const Color(0xFFF4F3FF),
  textTheme: TextTheme(
    bodySmall: GoogleFonts.montserrat(
        fontSize: 13, fontWeight: FontWeight.w400, color: primaryColorDark),
    bodyMedium: GoogleFonts.montserrat(
        fontSize: 16, fontWeight: FontWeight.w500, color: primaryColorDark),
    bodyLarge: GoogleFonts.montserrat(
        color: primaryColorDark, fontSize: 19, fontWeight: FontWeight.w600),
    titleSmall: GoogleFonts.montserrat(
        fontSize: 15, fontWeight: FontWeight.w600, color: primaryColorDark),
    titleMedium: GoogleFonts.montserrat(
        fontSize: 20, fontWeight: FontWeight.w600, color: primaryColorDark),
    titleLarge: GoogleFonts.montserrat(
        fontSize: 25, fontWeight: FontWeight.w700, color: primaryColorDark),
  ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ButtonStyle(
  //     minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
  //     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
  //       const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
  //     ),
  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  //       RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     ),
  //     textStyle: MaterialStateProperty.all<TextStyle>(
  //       const TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
  //     ),
  //   ),
  // ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontWeight: FontWeight.w600,
          decorationColor: splashColor,
          decoration: TextDecoration.underline,
        ),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(style: BorderStyle.solid, color: primaryColorDark),
    ),
  ),
);

InputBorder? inputBorder({bool dark = true, Color? color}) =>
    lightTheme.inputDecorationTheme.border?.copyWith(
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: color ??
            (dark
                ? lightTheme.primaryColorDark
                : lightTheme.scaffoldBackgroundColor),
      ),
    );
