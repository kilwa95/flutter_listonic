import 'dart:convert';

class Task {
  Task({
    required this.id,
    required this.title,
    this.description,
    this.completed = false,
  });

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      completed: jsonData['completed'],
    );
  }

  static Map<String, dynamic> toMap(Task task) => {
        'id': task.id,
        'title': task.title,
        'description': task.description,
        'completed': task.completed,
      };

  static String encode(List<Task> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((Task task) => Task.toMap(task))
            .toList(),
      );

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map<Task>((item) => Task.fromJson(item))
          .toList();

  String id;
  String title;
  String? description;
  bool completed;

  void toggleDone() {
    completed = !completed;
  }
}
