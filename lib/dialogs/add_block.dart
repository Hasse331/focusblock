import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/time_picker.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/storage/load_time_blocks.dart';
import 'package:time_blocking/storage/save_time_block.dart';
import 'package:time_blocking/utils/convert_to_time_of_day.dart';
import 'package:time_blocking/widgets/show_error.dart';

void addBlockDialog(context, Function updateState,
    {required String type, index, updateParent}) {
  TextEditingController nameController;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  late List<TimeBlock> timeBlocks = [];
  nameController = TextEditingController();

  int timeToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  // This dialog is reusable for new blocks and editing existing blocks
  // Use "Edit" or "New" strings for type variable

  type = type[0].toUpperCase() + type.substring(1);

  // Validating required arguments for edit mode
  if (type != "New") {
    if (index is! int || updateParent is! Function) {
      throw ArgumentError(
          "Error: when using 'Edit' mode: 1. valid index integer is required 2. updateParent function is required");
    }
  }

  if (type == "Edit") {
    loadTimeBlocks().then((blocks) {
      timeBlocks = blocks;

      // Prefill field controllers in correct format:
      nameController = TextEditingController(text: timeBlocks[index].blockName);
      // Reformat these to timeOfDay:
      startTime = convertStringToTimeOfDay(timeBlocks[index].startTime);
      endTime = convertStringToTimeOfDay(timeBlocks[index].endTime);
    });
  }

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
                textCapitalization: TextCapitalization.sentences,
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
                    if (type == "Edit") {
                      updateState();
                    }
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
