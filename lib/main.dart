import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listonic/interfaces/task_provider.dart';
import 'package:flutter_listonic/providers/firebase_task_provider.dart';
import 'package:flutter_listonic/screens/task_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Listonic());
}

class Listonic extends StatelessWidget {
  const Listonic({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskProvider>(
      create: (_) => FirebaseTaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<FirebaseApp>(
          future: Firebase.initializeApp(
            name: 'listonic',
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return const TaskScreen();
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
