import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/time_picker.dart';
import 'package:time_blocking/utils/save_time_block.dart';

void addBlockDialog(context, Function updateState) async {
  final TextEditingController nameController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
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
              TimePicker(
                  context: context,
                  type: "Start",
                  onTimeSet: (pickedTime) =>
                      setState(() => startTime = pickedTime)),
              // End time picker:
              TimePicker(
                context: context,
                type: "End",
                onTimeSet: (pickedTime) => setState(() => endTime = pickedTime),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    startTime != null &&
                    endTime != null) {
                  saveTimeBlock(
                      nameController.text, startTime!, endTime!, context);
                  updateState();
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    ),
  );
}
