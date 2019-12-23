import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      primaryColor: Colors.white,
      accentColor: Colors.black,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0.0,
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black,
          )
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        )
      )
    );
  }

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black45,
      accentColor: Colors.white,
    );
  }
}
