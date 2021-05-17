import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color grey = Color(0xff828282);

  ThemeData get lightTheme {
    final ThemeData baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      primaryColor: Colors.white,
      accentColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        textTheme: baseTheme.textTheme.copyWith(
          headline6: GoogleFonts.lato().copyWith(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      textTheme: baseTheme.textTheme.copyWith(
        bodyText1: GoogleFonts.lato().copyWith(color: Colors.black),
      ),
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black45,
      accentColor: Colors.white,
    );
  }
}

TextStyle bodyText1Style(BuildContext context,
    {Color color = Colors.black,
    double fontSize = 17.0,
    FontWeight fontWeight = FontWeight.normal}) {
  return Theme.of(context).textTheme.bodyText1.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      );
}
