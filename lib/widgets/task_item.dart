import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.isDone,
    required this.title,
    this.checkboxCallback,
    this.removeTaskCallback,
    this.editTaskCallback,
  });

  final bool isDone;
  final String title;
  final void Function(bool?)? checkboxCallback;
  final void Function()? removeTaskCallback;
  final void Function()? editTaskCallback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: editTaskCallback,
      leading: Checkbox(
        value: isDone,
        onChanged: checkboxCallback,
      ),
      title: Text(
        title,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
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
