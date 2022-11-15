import 'package:flutter/material.dart';
import 'package:flutter_listonic/providers/in_memory_provider.dart';
import 'package:flutter_listonic/screens/task_screen.dart';
import 'package:flutter_listonic/services/task_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Listonic());
}

class Listonic extends StatelessWidget {
  const Listonic({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskProvider>(
      create: (_) => InMemoryProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskScreen(),
      ),
    );
  }
}
