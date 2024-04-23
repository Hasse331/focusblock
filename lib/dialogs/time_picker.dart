import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key, required context, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          // Handle time here
        }
      },
      child: Text("Select $type Time"),
    );
  }
}
