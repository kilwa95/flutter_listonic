import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskForm extends StatelessWidget {
  const TaskForm({
    super.key,
    this.task,
    required this.submitButtonText,
    required this.onSubmit,
  });

  final Task? task;
  final String submitButtonText;
  final void Function(String, String) onSubmit;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleTextEditingController =
        TextEditingController(text: task?.title ?? "");
    final TextEditingController descriptionTextEditingController =
        TextEditingController(text: task?.description ?? "");

    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: titleTextEditingController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'title',
            ),
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: descriptionTextEditingController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'description',
            ),
          ),
          const SizedBox(height: 10.0),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              onSubmit(
                titleTextEditingController.value.text,
                descriptionTextEditingController.value.text,
              );
            },
            child: Text(
              submitButtonText,
            ),
          )
        ],
      ),
    );
  }
}
