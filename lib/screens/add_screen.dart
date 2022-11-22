import 'package:flutter/material.dart';
import 'package:flutter_listonic/interfaces/task_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/task_form.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: TaskForm(
        submitButtonText: "Add",
        onSubmit: (String title, String description) async {
          final NavigatorState navigator = Navigator.of(context);
          final TaskProvider taskProvider = context.read<TaskProvider>();
          await taskProvider.createTask(title, description);
          navigator.pop();
        },
      ),
    );
  }
}
