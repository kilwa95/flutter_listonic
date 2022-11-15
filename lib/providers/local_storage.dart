import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:flutter_listonic/services/task_provider.dart';

class LocalStorage extends ChangeNotifier implements TaskProvider {
  @override
  Future<Task> createTask(String title, String description) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTask(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Task> editTask(String id, String title, String description) {
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTasks() {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleTaskCompletion(String id) {
    throw UnimplementedError();
  }
}
