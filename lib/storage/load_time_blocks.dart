import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/time_block.dart';

Future<List<TimeBlock>> loadTimeBlocks() async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksJson = prefs.getString('timeBlocks') ?? '[]';

  final List<dynamic> decodedData = json.decode(timeBlocksJson);

  return decodedData
      .map((dynamic item) => TimeBlock.fromJson(item as Map<String, dynamic>))
      .toList();
}
