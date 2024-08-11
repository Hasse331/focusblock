import 'package:flutter/material.dart';

class MyTimePicker extends StatelessWidget {
  const MyTimePicker({
    super.key,
    required context,
    required this.type,
    required this.updateState,
    required this.selectedTime,
  });

  final String type;
  final Function(TimeOfDay) updateState;
  final TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          updateState(pickedTime);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (selectedTime == null) Text("$type Time"),
          if (selectedTime != null)
            Text(
              "Selected $type ${selectedTime!.format(context)}",
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
