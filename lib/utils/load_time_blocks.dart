import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> loadTimeBlocks() async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocks = prefs.getString('timeBlocks') ?? '[]';
  return json.decode(timeBlocks);
}
