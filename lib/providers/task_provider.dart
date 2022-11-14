import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';

Uuid uuid = const Uuid();

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];

  String taskTitle = "";
  String taskDescription = "";

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView<Task>(_tasks);
  }

  int get taskCount => _tasks.length;

  void addTask({required String newTaskTitle, String? newTaskDesc}) {
    final Task task = Task(
      id: uuid.v1(),
      title: newTaskTitle,
      description: newTaskDesc,
    );
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void setTaskDone(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void updateTask({
    required String id,
    required String newTaskTitle,
    required String newTaskDesc,
  }) {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    taskFound.title = newTaskTitle;
    taskFound.description = newTaskDesc;
    notifyListeners();
  }

  void setTaskTitle(String taskTitle) {
    this.taskTitle = taskTitle;
    notifyListeners();
  }

  void setTaskDescription(String taskDescription) {
    this.taskDescription = taskDescription;
    notifyListeners();
  }
}
