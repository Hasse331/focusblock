import 'package:flutter/material.dart';

class TimeBlock {
  String blockName;
  TimeOfDay startTime;
  TimeOfDay endTime;

  TimeBlock({
    required this.blockName,
    required this.startTime,
    required this.endTime,
  });
}
