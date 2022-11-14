import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_form.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('edit task'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('edit'),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          final TaskProvider taskProvider = context.read<TaskProvider>();
          // final TaskProvider taskProvider = context.watch<TaskProvider>();
          taskProvider.updateTask(
            id: task.id,
            newTaskTitle: taskProvider.taskTitle,
            newTaskDesc: taskProvider.taskDescription,
          );
          Navigator.pop(context);
        },
      ),
      body: TaskForm(task: task),
    );
  }
}
