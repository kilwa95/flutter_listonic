import 'package:flutter/material.dart';
import 'package:flutter_listonic/services/task_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

Uuid _uuid = const Uuid();

class InMemoryTaskProvider extends ChangeNotifier implements TaskProvider {
  final List<Task> _tasks = <Task>[];

  Task _findTaskById(String id) {
    return _tasks.firstWhere((Task task) => task.id == id);
  }

  @override
  Future<Task> createTask(String title, String description) async {
    final Task task = Task(
      id: _uuid.v4(),
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
    return task;
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _findTaskById(id);
    taskFound.title = title;
    taskFound.description = description;
    taskFound.lastUpdated = DateTime.now();
    notifyListeners();
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    _tasks.sort((Task a, Task b) => b.lastUpdated.compareTo(a.lastUpdated));
    return _tasks;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    notifyListeners();
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _findTaskById(id);
    taskFound.toggleDone();
    notifyListeners();
  }
}
