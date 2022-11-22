import 'package:flutter/cupertino.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:uuid/uuid.dart';

import '../interfaces/task_provider.dart';
import '../services/tasks/task_delete_service.dart';
import '../services/tasks/task_fetch_service.dart';
import '../services/tasks/task_save_service.dart';
import '../services/tasks/task_update_service.dart';

class ApiTaskProvider extends ChangeNotifier implements TaskProvider {
  final TaskFetchService _taskFetchService = TaskFetchService();
  final TaskSaveService _taskSaveService = TaskSaveService();
  final TaskUpdateService _taskUpdateService = TaskUpdateService();
  final TaskDeleteService _taskDeleteService = TaskDeleteService();

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
    await _taskSaveService.createTaskFromApi(title, description);
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    notifyListeners();
    await _taskDeleteService.deleteTaskFromApi(id);
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _findTaskById(id);
    taskFound.title = title;
    taskFound.description = description;
    taskFound.lastUpdated = DateTime.now();
    notifyListeners();
    await _taskUpdateService.editTaskFromApi(id, title, description);
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    _tasks = await _taskFetchService.getAllTasksFromApi();
    return _tasks;
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _findTaskById(id);
    taskFound.toggleDone();
    await _taskUpdateService.toggleTaskCompletionFromApi(id);
    notifyListeners();
  }
}
