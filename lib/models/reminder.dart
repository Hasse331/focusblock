class Reminder {
  int? id; // Optional: Auto-incremented in the database
  String title;
  String description;
  DateTime scheduledTime;
  bool isActive;

  Reminder({
    this.id,
    required this.title,
    required this.description,
    required this.scheduledTime,
    this.isActive = true, // Default to true when created
  });

  // Convert a Reminder into a Map. The keys must correspond to the column names in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduledTime': scheduledTime.toIso8601String(),
      'isActive':
          isActive ? 1 : 0, // Store as int for SQLite (1 for true, 0 for false)
    };
  }

  // Create a Reminder from a Map (useful for retrieving data from the database)
  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      scheduledTime: DateTime.parse(map['scheduledTime']),
      isActive: map['isActive'] == 1,
    );
  }
}
