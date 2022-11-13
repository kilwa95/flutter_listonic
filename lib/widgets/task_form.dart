import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'title',
            ),
            textAlign: TextAlign.center,
            onChanged: (String title) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setTaskTitle(title);
            },
          ),
          const SizedBox(height: 20.0),
          TextField(
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'description',
            ),
            textAlign: TextAlign.center,
            onChanged: (String description) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setTaskDescription(description);
            },
          ),
        ],
      ),
    );
  }
}
