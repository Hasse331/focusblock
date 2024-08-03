import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateTimeBlocks(List<dynamic> updatedList) async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('timeBlocks', json.encode(updatedList));
}
