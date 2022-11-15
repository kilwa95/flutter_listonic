import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.task,
    required this.checkboxCallback,
    required this.removeTaskCallback,
    required this.editTaskCallback,
  });

  final void Function(bool?) checkboxCallback;
  final void Function() removeTaskCallback;
  final void Function() editTaskCallback;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: editTaskCallback,
      leading: Checkbox(
        value: task.completed,
        onChanged: checkboxCallback,
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.completed ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: GestureDetector(
        onTap: removeTaskCallback,
        child: const Icon(
          Icons.close,
          color: Colors.red,
        ),
      ),
    );
  }
}
