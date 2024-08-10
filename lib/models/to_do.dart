class ToDoItem {
  final String name;
  final bool isChecked;

  ToDoItem({required this.name, this.isChecked = false});

  factory ToDoItem.fromJson(Map<String, dynamic> json) => ToDoItem(
      name: json["name"] as String, isChecked: json["isChecked"] as bool);
}
