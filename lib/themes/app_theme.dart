import 'package:flutter/material.dart';
import 'package:productos_app/utils/app_color.dart';

ThemeData getAppTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.grey[300],
    appBarTheme: const AppBarTheme(elevation: 0, color: AppColor.accentColor),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: AppColor.accentColor, elevation: 0),
  );
}
