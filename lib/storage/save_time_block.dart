import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTimeBlock(String blockName, TimeOfDay startTime,
    TimeOfDay endTime, String type, context,
    {index}) async {
  final prefs = await SharedPreferences.getInstance();
  // Get currently saved data:
  final timeBlocks = prefs.getString('timeBlocks') ?? '[]';
  // Decode for operations
  List<dynamic> blocks = json.decode(timeBlocks);

  // Edti current timeblocks by received index
  if (type == "Edit") {
    blocks[index] = {
      'blockName': blockName,
      'startTime': startTime.format(context),
      'endTime': endTime.format(context),
    };
  }

  // Add new timeBlock to map
  if (type == "New") {
    final Map<String, dynamic> newBlock = {
      'blockName': blockName,
      'startTime': startTime.format(context),
      'endTime': endTime.format(context),
    };
    blocks.add(newBlock);
  }

  await prefs.setString('timeBlocks', json.encode(blocks));
}
