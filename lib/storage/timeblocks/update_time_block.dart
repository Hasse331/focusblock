import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/time_block.dart';

Future<void> updateTimeBlocks(List<TimeBlock> timeBlocks) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksJson =
      jsonEncode(timeBlocks.map((block) => block.toJson()).toList());
  await prefs.setString('timeBlocks', timeBlocksJson);
}
