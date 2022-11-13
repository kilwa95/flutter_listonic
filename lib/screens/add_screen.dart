import 'package:flutter/material.dart';
import 'package:flutter_listonic/providers/task_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/task_form.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add task'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('submit'),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Provider.of<TaskProvider>(context, listen: false).addTask(
            newTaskTitle:
                Provider.of<TaskProvider>(context, listen: false).taskTitle,
            newTaskDesc: Provider.of<TaskProvider>(context, listen: false)
                .taskDescription,
          );
          Navigator.pop(context);
        },
      ),
      body: const TaskForm(),
    );
  }
}
