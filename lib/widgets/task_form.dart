import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({super.key, this.task});

  final Task? task;

  @override
  Widget build(BuildContext context) {
    final TaskProvider taskProvider = context.read<TaskProvider>();
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: TextEditingController(text: task?.title),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'title',
            ),
            onChanged: (String title) {
              taskProvider.setTaskTitle(title);
            },
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: TextEditingController(text: task?.description),
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'description',
            ),
            onChanged: (String description) {
              taskProvider.setTaskDescription(description);
            },
          ),
        ],
      ),
    );
  }
}
