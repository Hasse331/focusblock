import 'dart:convert';

import 'package:time_blocking/models/time_block.dart';

class Template {
  String name;
  List<TimeBlock> templates;

  Template({required this.name, required this.templates});

  factory Template.fromJson(Map<String, dynamic> json) => Template(
      name: json["name"] as String,
      templates: (json['templates'] as List)
          .map((timeBlockJson) => TimeBlock.fromJson(timeBlockJson))
          .toList());

  Map<String, dynamic> toJson() => {
        'name': name,
        'templates': json.encode(templates),
      };
}
