import 'package:flutter_listonic/services/tasks/task_firebase_service.dart';

import '../interfaces/task_provider.dart';
import '../models/task.dart';

class FirebaseTaskProvider extends TaskProvider {
  final TaskFireBaseService _taskFireBaseService = TaskFireBaseService();

  @override
  Future<List<Task>> getAllTasks() async {
    final List<Task> tasks = await super.getAllTasks();
    final List<Task> firebaseTasks =
        await _taskFireBaseService.getAllTasksFromFirebase();
    if (tasks.isEmpty) {
      tasks.addAll(firebaseTasks);
    }
    return tasks;
  }

  @override
  Future<void> createTask(
    String title,
    String description, {
    String? id,
  }) async {
    final String id = await _taskFireBaseService.createTaskFromFirebase(
      title,
      description,
    );
    await super.createTask(title, description, id: id);
  }

  @override
  Future<void> deleteTask(String id) async {
    await super.deleteTask(id);
    await _taskFireBaseService.deleteTaskFromFirebase(id);
  }

  @override
  Future<void> editTask(String id, String title, String description) async {
    await _taskFireBaseService.editTaskFromFirebase(
      id,
      title,
      description,
    );
    await super.editTask(id, title, description);
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    await super.toggleTaskCompletion(id);
    await _taskFireBaseService.toggleTaskCompletionFromFirebase(id);
  }
}
