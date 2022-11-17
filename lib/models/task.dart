class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
    DateTime? date,
  }) : date = date ?? DateTime.now();

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        completed = map['completed'],
        date = map['date'];

  String id;
  String title;
  String? description;
  bool completed;
  DateTime date;

  void toggleDone() {
    completed = !completed;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
