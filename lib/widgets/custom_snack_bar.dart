import 'package:flutter/material.dart';

class CustomSnackBar {
  const CustomSnackBar();
 static  snackBarwidget(
      {required BuildContext context,
      required Color color,
      required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          margin: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
          content: Text(text)),
    );
  }
}
