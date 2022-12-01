import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listonic/interfaces/task_provider.dart';
import 'package:flutter_listonic/providers/api_task_provider.dart';
import 'package:flutter_listonic/providers/firebase_task_provider.dart';
import 'package:flutter_listonic/providers/in_memory_task_provider.dart';
import 'package:flutter_listonic/providers/local_storage_task_provider.dart';
import 'package:flutter_listonic/screens/add_screen.dart';
import 'package:flutter_listonic/screens/task_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main({String? provider}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(Listonic(typeProvider: provider));
}

class Listonic extends StatelessWidget {
  const Listonic({super.key, this.typeProvider});

  final String? typeProvider;

  TaskProvider _runAppWithTypeProvider() {
    switch (typeProvider) {
      case 'api':
        return ApiTaskProvider();
      case 'firebase':
        return FirebaseTaskProvider();
      case 'local':
        return LocalStorageTaskProvider();
      case 'memory':
        return InMemoryTaskProvider();
      default:
        return FirebaseTaskProvider();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskProvider>(
      create: (_) => _runAppWithTypeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AddScreen.routeName: (BuildContext context) => const AddScreen(),
        },
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
