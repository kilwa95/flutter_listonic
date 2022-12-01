import 'dart:convert';

import 'package:flutter_listonic/interfaces/task_provider.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/shared_pref_helper.dart';

String kTasks = 'tasks';

class LocalStorageTaskProvider extends TaskProvider {
  LocalStorageTaskProvider() {
    SharedPreferencesHelper.init().then((_) async {
      sharedPreferences = SharedPreferencesHelper.instance;

      if (!sharedPreferences!.containsKey(kTasks)) {
        await sharedPreferences!.setStringList(kTasks, const <String>[]);
      }
      _loadDataFromLocalStorage();
      notifyListeners();
    });
  }

  List<Task> _tasks = <Task>[];

  SharedPreferences? sharedPreferences;

  void _loadDataFromLocalStorage() {
    final List<String>? spTasks = sharedPreferences!.getStringList(kTasks);
    if (spTasks != null) {
      _tasks = spTasks
          .map((String item) => Task.fromMap(json.decode(item)))
          .toList();
    }
  }

  void _saveDataToLocalStorage() {
    final List<String> spList =
        _tasks.map((Task item) => json.encode(item.toMap())).toList();
    sharedPreferences!.setStringList(kTasks, spList);
  }

  @override
  Future<void> createTask(
    String title,
    String description, {
    String? id,
  }) async {
    await super.createTask(title, description);
    _saveDataToLocalStorage();
  }

  @override
  Future<void> deleteTask(String id) async {
    await super.deleteTask(id);
    _saveDataToLocalStorage();
  }

  @override
  Future<void> editTask(String id, String title, String description) async {
    await super.editTask(id, title, description);
    _saveDataToLocalStorage();
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    await super.toggleTaskCompletion(id);
    _saveDataToLocalStorage();
  }
}
