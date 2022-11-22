class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
    DateTime? date,
  }) : lastUpdated = date ?? DateTime.now();

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        completed = map['completed'],
        lastUpdated = DateTime.parse(map['lastUpdated']);

  String id;
  String title;
  String? description;
  bool completed;
  DateTime lastUpdated;

  void toggleDone() {
    completed = !completed;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'lastUpdated': lastUpdated,
    };
  }
}
