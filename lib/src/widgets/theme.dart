import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color grey = Color(0xff828282);

  ThemeData get lightTheme {
    final ThemeData baseTheme = ThemeData.light();
    return baseTheme.copyWith(
      colorScheme: ColorScheme.light().copyWith(
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        surface: Colors.black,
        onSurface: Colors.black,
        background: Colors.white,
        onBackground: Colors.black,
      ),
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
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.white,
      ),
      textTheme: baseTheme.textTheme.copyWith(
        bodyText1: GoogleFonts.lato().copyWith(color: Colors.black),
      ),
    );
  }

  ThemeData get darkTheme {
    final ThemeData baseTheme = ThemeData.dark();
    return baseTheme.copyWith(
      colorScheme: ColorScheme.dark().copyWith(
        primary: Colors.black45.withOpacity(0.4),
        onPrimary: Colors.white.withOpacity(0.9),
        secondary: Colors.white,
        onSecondary: Colors.black,
        surface: Colors.black45.withOpacity(0.4),
        onSurface: Colors.white.withOpacity(0.9),
        background: Colors.black45.withOpacity(0.4),
        onBackground: Colors.white.withOpacity(0.9),
      ),
      scaffoldBackgroundColor: Colors.black45.withOpacity(0.4),
      appBarTheme: AppBarTheme(
        color: Colors.black45.withOpacity(0.4),
        // elevation: 0.0,
        textTheme: baseTheme.textTheme.copyWith(
          headline6: GoogleFonts.lato().copyWith(
            color: Colors.white.withOpacity(0.6),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.6),
        ),
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.black45.withOpacity(0.4), elevation: 0.0),
      dividerColor: Colors.grey,
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
