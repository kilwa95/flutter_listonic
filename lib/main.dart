import 'package:flutter/material.dart';
import 'package:flutter_listonic/providers/task_provider.dart';
import 'package:flutter_listonic/screens/task_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Listonic());
}

class Listonic extends StatelessWidget {
  const Listonic({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: const MaterialApp(
        home: TaskScreen(),
      ),
    );
  }
}
