class ToDoItem {
  String name;
  bool isChecked;

  ToDoItem({required this.name, this.isChecked = false});

  factory ToDoItem.fromJson(Map<String, dynamic> json) => ToDoItem(
      name: json["name"] as String, isChecked: json["isChecked"] == true);

  Map<String, dynamic> toJson() => {
        'name': name,
        'isChecked': isChecked.toString(),
      };
}
