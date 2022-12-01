import 'package:flutter_listonic/models/task.dart';
import 'package:flutter_listonic/services/tasks/task_api_service.dart';

import '../interfaces/task_provider.dart';

class ApiTaskProvider extends TaskProvider {
  final TaskApiService _taskApiService = TaskApiService();

  @override
  Future<List<Task>> getAllTasks() async {
    final List<Task> tasks = await super.getAllTasks();
    final List<Task> apiTasks = await _taskApiService.getAllTasksFromApi();
    if (tasks.isEmpty) {
      tasks.addAll(apiTasks);
    }
    return tasks;
  }

  @override
  Future<void> createTask(
    String title,
    String description, {
    String? id,
  }) async {
    await super.createTask(title, description);
    await _taskApiService.createTaskFromApi(title, description);
  }

  @override
  Future<void> editTask(String id, String title, String description) async {
    await super.editTask(id, title, description);
    await _taskApiService.editTaskFromApi(id, title, description);
  }

  @override
  Future<void> deleteTask(String id) async {
    await super.deleteTask(id);
    await _taskApiService.deleteTaskFromApi(id);
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    await super.toggleTaskCompletion(id);
    await _taskApiService.toggleTaskCompletionFromApi(id);
  }
}
