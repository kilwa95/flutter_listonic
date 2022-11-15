import 'package:flutter/material.dart';
import 'package:flutter_listonic/services/task_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

Uuid uuid = const Uuid();

class InMemoryProvider extends ChangeNotifier implements TaskProvider {
  final List<Task> _tasks = <Task>[];

  @override
  Future<Task> createTask(String title, String description) async {
    final Task task = Task(
      id: uuid.v1(),
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
    return task;
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    taskFound.title = title;
    taskFound.description = description;
    notifyListeners();
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return _tasks;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    _tasks.remove(taskFound);
    notifyListeners();
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    taskFound.toggleDone();
    notifyListeners();
  }
}
