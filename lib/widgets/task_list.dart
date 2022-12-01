import 'package:flutter/material.dart';
import 'package:flutter_listonic/interfaces/task_provider.dart';
import 'package:flutter_listonic/screens/edit_screen.dart';
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
              itemCount: tasks.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index == tasks.length) {
                  return const SizedBox(
                    height: 100,
                  );
                }

                final Task task = tasks[index];
                return TaskItem(
                  task: task,
                  checkboxCallback: (_) {
                    taskProvider.toggleTaskCompletion(task.id);
                  },
                  removeTaskCallback: () {
                    taskProvider.deleteTask(task.id);
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
            );
          },
        );
      },
    );
  }
}
