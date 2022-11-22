import 'package:flutter/material.dart';
import 'package:flutter_listonic/interfaces/task_provider.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../widgets/task_form.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit task'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: TaskForm(
        task: task,
        submitButtonText: "Edit",
        onSubmit: (String title, String description) async {
          final TaskProvider taskProvider = context.read<TaskProvider>();
          final NavigatorState navigator = Navigator.of(context);
          await taskProvider.editTask(
            task.id,
            title,
            description,
          );
          navigator.pop();
        },
      ),
    );
  }
}
