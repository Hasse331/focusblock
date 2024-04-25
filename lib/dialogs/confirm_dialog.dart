import 'package:flutter/material.dart';

void confirmDialog(
  context,
  updateState, {
  required Function action,
  required String title,
  required String message,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              action();
              updateState();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Continue",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
