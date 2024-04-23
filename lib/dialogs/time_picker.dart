import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker(
      {super.key,
      required context,
      required this.type,
      required this.onTimeSet});

  final String type;
  final Function(TimeOfDay) onTimeSet;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          onTimeSet(pickedTime);
        }
      },
      child: Text("$type Time"),
    );
  }
}
