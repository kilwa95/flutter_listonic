import 'package:flutter/material.dart';
import 'package:flutter_listonic/widgets/task_item.dart';
import 'package:provider/provider.dart';

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
            return TaskItem(
              title: taskProvider.tasks[index].title,
              isDone: taskProvider.tasks[index].completed,
              checkboxCallback: (bool? checkBoxState) {
                taskProvider.setTaskDone(taskProvider.tasks[index]);
              },
              removeTaskCallback: () {
                taskProvider.deleteTask(taskProvider.tasks[index]);
              },
            );
          },
          itemCount: taskProvider.taskCount,
        );
      },
    );
  }
}
