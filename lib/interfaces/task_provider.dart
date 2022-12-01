import 'package:flutter/material.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:uuid/uuid.dart';

abstract class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];
  final Uuid _uuid = const Uuid();

  Task _findTaskById(String id) {
    return _tasks.firstWhere((Task task) => task.id == id);
  }

  String _generateId() {
    return _uuid.v4();
  }

  Future<List<Task>> getAllTasks() async {
    _tasks.sort((Task a, Task b) => b.lastUpdated.compareTo(a.lastUpdated));
    return _tasks;
  }

  Future<void> createTask(
    String title,
    String description, {
    String? id,
  }) async {
    final Task task = Task(
      id: id ?? _generateId(),
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> editTask(String id, String title, String description) async {
    final Task taskFound = _findTaskById(id);
    taskFound.title = title;
    taskFound.description = description;
    taskFound.lastUpdated = DateTime.now();
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _findTaskById(id);
    taskFound.toggleDone();
    notifyListeners();
  }
}
