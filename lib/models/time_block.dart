import 'package:flutter/material.dart';
import 'package:time_blocking/models/links.dart';
import 'package:time_blocking/models/to_do.dart';

// TODO: Define, understand and use this data type correctly

// Currently this model is not used anywhere and may be incorrecly defined

class TimeBlock {
  final String blockName;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? description;
  final List<ToDoItem>? toDoItems;
  final List<Links>? links;

  TimeBlock({
    required this.blockName,
    required this.startTime,
    required this.endTime,
    this.description,
    this.toDoItems,
    this.links,
  });
}
