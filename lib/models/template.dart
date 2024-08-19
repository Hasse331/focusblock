import 'dart:convert';

import 'package:time_blocking/models/time_block.dart';

class Template {
  String name;
  List<TimeBlock> timeBlock;

  Template({required this.name, required this.timeBlock});

  factory Template.fromJson(Map<String, dynamic> json) => Template(
      name: json["name"] as String,
      timeBlock: (json['timeBlocks'] as List)
          .map((timeBlockJson) => TimeBlock.fromJson(timeBlockJson))
          .toList());

  Map<String, dynamic> toJson() => {
        'name': name,
        'timeBlock': json.encode(timeBlock),
      };
}
