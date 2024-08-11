import 'package:flutter/material.dart';

TimeOfDay convertStringToTimeOfDay(String timeString) {
  List<String> timeParts = timeString.split(' ');

  final splitTime = timeParts[0].split(':');
  int hours = int.parse(splitTime[0]);
  int minute = int.parse(splitTime[1]);

  if (timeParts.length > 1) {
    if (timeParts[1] == 'PM' && hours != 12) {
      hours += 12;
    } else if (timeParts[1] == 'AM' && hours == 12) {
      hours = 0;
    }
  }

  return TimeOfDay(hour: hours, minute: minute);
}
