import 'package:flutter/cupertino.dart';
import 'package:flutter_listonic/services/tasks/task_delete_service.dart';
import 'package:flutter_listonic/services/tasks/task_save_service.dart';
import 'package:flutter_listonic/services/tasks/task_update_service.dart';

import '../interfaces/task_provider.dart';
import '../models/task.dart';
import '../services/tasks/task_fetch_service.dart';

class FirebaseTaskProvider extends ChangeNotifier implements TaskProvider {
  final TaskFetchService _taskFetchService = TaskFetchService();
  final TaskSaveService _taskSaveService = TaskSaveService();
  final TaskUpdateService _taskUpdateService = TaskUpdateService();
  final TaskDeleteService _taskDeleteService = TaskDeleteService();
  List<Task> _tasks = <Task>[];

  Task _findTaskById(String id) {
    return _tasks.firstWhere((Task task) => task.id == id);
  }

  @override
  Future<Task> createTask(String title, String description) async {
    final String id = await _taskSaveService.createTaskFromFirebase(
      title,
      description,
    );
    final Task task = Task(
      id: id,
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    notifyListeners();
    await _taskDeleteService.deleteTaskFromFirebase(id);
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _findTaskById(id);
    taskFound.title = title;
    taskFound.description = description;
    taskFound.lastUpdated = DateTime.now();
    notifyListeners();
    await _taskUpdateService.editTaskFromFirebase(
      id,
      title,
      description,
    );
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    if (_tasks.isEmpty) {
      _tasks = await _taskFetchService.getAllTasksFromFirebase();
    }
    return _tasks;
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _findTaskById(id);
    taskFound.toggleDone();
    notifyListeners();
    await _taskUpdateService.toggleTaskCompletionFromFirebase(id);
  }
}
