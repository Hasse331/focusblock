import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveBlockDescription(int index, String description) async {
  final prefs = await SharedPreferences.getInstance();
  // Get currently saved data:
  final timeBlocks = prefs.getString('timeBlocks') ?? '[]';
  // Decode for operations
  List<dynamic> blocks = json.decode(timeBlocks);

  blocks[index]["description"] = description;

  await prefs.setString('timeBlocks', json.encode(blocks));
}
