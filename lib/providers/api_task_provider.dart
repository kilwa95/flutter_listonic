import 'package:flutter/cupertino.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:uuid/uuid.dart';

import '../services/network_helper.dart';
import '../services/task_provider.dart';

class ApiTaskProvider extends ChangeNotifier implements TaskProvider {
  NetworkHelper? networkHelper = NetworkHelper();
  List<Task> _tasks = <Task>[];
  final Uuid _uuid = const Uuid();

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
    await networkHelper?.createTaskFromApi(title, description);
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    notifyListeners();
    await networkHelper?.deleteTaskFromApi(id);
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _findTaskById(id);
    taskFound.title = title;
    taskFound.description = description;
    notifyListeners();
    await networkHelper?.editTaskFromApi(id, title, description);
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return _tasks = await networkHelper?.getAllTasksFromApi() as List<Task>;
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _findTaskById(id);
    taskFound.toggleDone();
    await networkHelper?.toggleTaskCompletionFromApi(id);
    notifyListeners();
  }
}
