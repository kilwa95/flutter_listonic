class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  String id;
  String title;
  String? description;
  bool completed;

  void toggleDone() {
    completed = !completed;
  }
}
