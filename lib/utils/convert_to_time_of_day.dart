import 'package:flutter/material.dart';

TimeOfDay convertStringToTimeOfDay(String timeString) {
  final splitTime = timeString.split(':');
  final hour = int.parse(splitTime[0]);
  final minute = int.parse(splitTime[1]);
  return TimeOfDay(hour: hour, minute: minute);
}
