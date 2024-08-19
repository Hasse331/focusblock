import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/template.dart';

Future<List<Template>> loadTemplates() async {
  final prefs = await SharedPreferences.getInstance();
  final templatesJson = prefs.getString('templates') ?? '[]';

  final List<dynamic> decodedData = json.decode(templatesJson);

  return decodedData
      .map((dynamic item) => Template.fromJson(item as Map<String, dynamic>))
      .toList();
}
