import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/time_picker.dart';
import 'package:time_blocking/storage/save_time_block.dart';
import 'package:time_blocking/widgets/show_error.dart';

void addBlockDialog(context, Function updateState,
    {required String type, index}) async {
  final TextEditingController nameController = TextEditingController();
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  int timeToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  // This dialog is reusable for new blocks and editing existing blocks
  // Use "Edit" or "New" strings for type variable

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text('$type Time Block'),
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
              MyTimePicker(
                context: context,
                type: "Start",
                updateState: (pickedTime) =>
                    setState(() => startTime = pickedTime),
                selectedTime: startTime,
              ),
              // End time picker:
              MyTimePicker(
                context: context,
                type: "End",
                updateState: (pickedTime) =>
                    setState(() => endTime = pickedTime),
                selectedTime: endTime,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            // Save button
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    startTime != null &&
                    endTime != null) {
                  if (timeToMinutes(endTime!) - timeToMinutes(startTime!) >=
                      30) {
                    saveTimeBlock(nameController.text, startTime!, endTime!,
                        type, context,
                        index: index);
                    updateState();
                    Navigator.of(context).pop();
                  } else {
                    showError(context, "Block has to be +30 min long");
                  }
                } else {
                  showError(
                      context, "Missing: block name, start time or end time");
                }
              },
              child: Text("$type Block"),
            ),
          ],
        );
      },
    ),
  );
}
