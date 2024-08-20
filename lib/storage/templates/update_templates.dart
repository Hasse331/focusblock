import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_blocking/models/template.dart';

Future<void> updateTemplates(List<Template> templates) async {
  final prefs = await SharedPreferences.getInstance();
  final templatesJson =
      jsonEncode(templates.map((item) => item.toJson()).toList());
  await prefs.setString('templates', templatesJson);
  // TALLENTAA SIIS TEMPLATES -> TYYPPIÄ STRING. MIKÄ ON VÄÄRIN!!!
}
