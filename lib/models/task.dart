class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        title = map['title'],
        description = map['description'],
        completed = map['completed'];

  String id;
  String title;
  String? description;
  bool completed;

  void toggleDone() {
    completed = !completed;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
    };
  }
}
