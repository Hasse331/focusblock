import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/time_picker.dart';

void addBlockDialog(context) async {
  final TextEditingController nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('New Time Block'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Block name: ',
              ),
            ),
            // Start time picker:
            TimePicker(context: context, type: "Start"),
            // End time picker:
            TimePicker(context: context, type: "End")
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => {Navigator.of(context).pop()},
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
