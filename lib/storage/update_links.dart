import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/links.dart';

Future<void> updateLinks(
    {required int blockIndex, required List<Link> links}) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksString = prefs.getString('timeBlocks') ?? '[]';
  final List<dynamic> blocks = jsonDecode(timeBlocksString);

  if (blockIndex >= 0 && blockIndex < blocks.length) {
    blocks[blockIndex]["links"] = links;
    await prefs.setString('timeBlocks', jsonEncode(blocks));
  }
}
