import 'package:flutter/material.dart';

class TimeBlock {
  String blockName;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String? description;
  List<String>? toDo;

  TimeBlock({
    required this.blockName,
    required this.startTime,
    required this.endTime,
    this.description,
  });
}
