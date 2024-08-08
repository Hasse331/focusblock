import 'package:flutter/material.dart';

class TimeBlock {
  String blockName;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String? description;
  String? toDoName;
  bool? toDoChecked;

  TimeBlock({
    required this.blockName,
    required this.startTime,
    required this.endTime,
    this.description,
    this.toDoName,
    this.toDoChecked,
  });
}
