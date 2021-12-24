import 'package:flutter/material.dart';

//Custom class in project directory
class CustomWidgets {
  CustomWidgets._();
  static buildSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: '✘',
          onPressed: () {
            ScaffoldMessengerState().removeCurrentSnackBar();
          },
        ),
        content: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(message),
        ),
        duration: const Duration(milliseconds: 1000),
        // width: MediaQuery.of(context).size.width - 40,
        margin: const EdgeInsets.only(bottom: 100, right: 20, left: 20),
        // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}