import 'package:flutter/material.dart';
import 'package:flutter_listonic/models/task.dart';

abstract class TaskProvider extends ChangeNotifier {
  Future<List<Task>> getAllTasks();

  Future<Task> createTask(String title, String description);

  Future<Task> editTask(String id, String title, String description);

  Future<void> deleteTask(String id);

  Future<void> toggleTaskCompletion(String id);
}
