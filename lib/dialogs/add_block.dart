import 'package:flutter/material.dart';
import 'package:time_blocking/dialogs/time_picker.dart';
import 'package:time_blocking/dialogs/select_dialog.dart';
import 'package:time_blocking/models/time_block.dart';
import 'package:time_blocking/storage/timeblocks/load_time_blocks.dart';
import 'package:time_blocking/storage/timeblocks/save_time_block.dart';
import 'package:time_blocking/utils/convert_to_time_of_day.dart';
import 'package:time_blocking/widgets/show_error.dart';

// TODO: REFACTOR: This could be reasonably statefulWidget instead of a function
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
          contentPadding: const EdgeInsets.only(bottom: 0),
          title: Text('$type Time Block'),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
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
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => SelectDialog(
                            updateState,
                            selectToDoBlock: true,
                          ),
                        );
                      },
                      child: const Text("To Do Block")),
                ),
              ],
            ),
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
                      15) {
                    if (nameController.text.length < 40) {
                      saveTimeBlock(nameController.text, startTime!, endTime!,
                          type, context,
                          index: index);
                      updateState();
                      if (type == "Edit") {
                        updateState();
                      }
                      Navigator.of(context).pop();
                    } else {
                      showError(
                          context, "Block name has to be less than 40 letters");
                    }
                  } else {
                    showError(context, "Block has to be +15 min long");
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
