import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveTimeBlock(
    String blockName, TimeOfDay startTime, TimeOfDay endTime, context) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocks = prefs.getString('timeBlocks') ?? '[]';
  List<dynamic> blocks = json.decode(timeBlocks);

  final Map<String, dynamic> newBlock = {
    'blockName': blockName,
    'startTime': startTime.format(context),
    'endTime': endTime.format(context),
  };

  blocks.add(newBlock);

  await prefs.setString('timeBlocks', json.encode(blocks));
}
