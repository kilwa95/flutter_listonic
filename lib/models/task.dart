class Task {
  Task({
    this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  int? id;
  String title;
  String? description;
  bool completed;

  void toggleDone() {
    completed = !completed;
  }
}
