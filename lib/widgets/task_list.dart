import 'package:flutter/material.dart';
import 'package:flutter_listonic/screens/edit_screen.dart';
import 'package:flutter_listonic/services/task_provider.dart';
import 'package:flutter_listonic/widgets/task_item.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (
        BuildContext context,
        TaskProvider taskProvider,
        Widget? child,
      ) {
        return FutureBuilder<List<Task>>(
          future: taskProvider.getAllTasks(),
          initialData: const <Task>[],
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
            if (snapshot.hasError) {
              return const Text('Error loading tasks');
            }

            if (!snapshot.hasData) {
              return const Text('Unable to retrieve tasks');
            }

            final List<Task> tasks = snapshot.data!;

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final Task task = tasks[index];
                return TaskItem(
                  task: task,
                  checkboxCallback: (_) async {
                    await taskProvider.toggleTaskCompletion(task.id);
                  },
                  removeTaskCallback: () async {
                    await taskProvider.deleteTask(task.id);
                  },
                  editTaskCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) =>
                            EditScreen(task: task),
                      ),
                    );
                  },
                );
              },
              itemCount: tasks.length,
            );
          },
        );
      },
    );
  }
}
