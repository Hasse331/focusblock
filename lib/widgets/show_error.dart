import 'package:flutter/material.dart';

void showError(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3), // Adjust duration as needed
  );

  // Find the closest ScaffoldMessenger and show the SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
