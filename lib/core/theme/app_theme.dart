import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 3),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(AppPallete.backgroundColor),
      side: BorderSide.none,
    ),
    appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
