import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLink({required int blockIndex, required String link}) async {
  final prefs = await SharedPreferences.getInstance();
  final timeBlocksString = prefs.getString('timeBlocks') ?? '[]';
  final List<dynamic> blocks = jsonDecode(timeBlocksString);

  if (blockIndex >= 0 && blockIndex < blocks.length) {
    final timeBlock = blocks[blockIndex] as Map<String, dynamic>;
    if (!timeBlock.containsKey('links') || timeBlock["links"] == null) {
      timeBlock['links'] = [];
    }
    RegExp regExp;
    if (link.contains("https://www.")) {
      regExp = RegExp(r'(?<=www\.)([a-zA-Z]+)');
    } else if (link.contains("https://")) {
      regExp = RegExp(r'(?<=//)([a-zA-Z]+)');
    } else {
      regExp = RegExp(r'(?<=www\.)([a-zA-Z]+)');
      link = 'https://www.$link';
    }

    // Extract the match from the URL
    String? linkName = regExp.firstMatch(link)?.group(0);

    final links = timeBlock['links'] as List<dynamic>;
    links.add({'name': linkName ?? link, 'link': link});
    await prefs.setString('timeBlocks', jsonEncode(blocks));
  }
}
