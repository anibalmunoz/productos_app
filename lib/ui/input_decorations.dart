import 'package:flutter/material.dart';
import 'package:productos_app/utils/app_color.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
          {required String hintText, required String labelText, IconData? prefixIcon}) =>
      InputDecoration(
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColor.primaryColor, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColor.secundaryColor) : null,
      );
}
