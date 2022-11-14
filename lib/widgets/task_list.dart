import 'package:flutter/material.dart';
import 'package:flutter_listonic/widgets/task_item.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';

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
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final Task task = taskProvider.tasks[index];
            return TaskItem(
              title: task.title,
              isDone: task.completed,
              checkboxCallback: (_) {
                taskProvider.setTaskDone(task);
              },
              removeTaskCallback: () {
                taskProvider.deleteTask(task);
              },
            );
          },
          itemCount: taskProvider.taskCount,
        );
      },
    );
  }
}
