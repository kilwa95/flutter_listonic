import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = <Task>[];

  String taskTitle = "";
  String taskDescription = "";

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView<Task>(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask({required String newTaskTitle, String? newTaskDesc}) {
    final Task task = Task(title: newTaskTitle, description: newTaskDesc);
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

  void setTaskTitle(String taskTitle) {
    this.taskTitle = taskTitle;
    notifyListeners();
  }

  void setTaskDescription(String taskDescription) {
    this.taskDescription = taskDescription;
    notifyListeners();
  }
}
