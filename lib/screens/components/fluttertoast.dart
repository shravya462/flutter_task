import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ToastHelper {
  // Shows a toast message
  static void showToast(String message,
      {Toast length = Toast.LENGTH_LONG,
      Color? backgroundColor,
      Color? textColor,
      double fontSize = 16.0}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: textColor ?? Colors.white,
      fontSize: fontSize,
    );
  }
}
