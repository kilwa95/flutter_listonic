import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:flutter_listonic/services/task_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../services/shared_pref_helper.dart';

Uuid _uuid = const Uuid();
String kTasks = 'tasks';

class LocalStorageTaskProvider extends ChangeNotifier implements TaskProvider {
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

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView<Task>(_tasks);

  Task _findTaskById(String id) {
    return _findTaskById(id);
  }

  T _commit<T>(T Function() transaction, {bool mustNotify = true}) {
    final T transactionResult = transaction();

    if (mustNotify) {
      notifyListeners();
    }

    _saveDataToLocalStorage();

    return transactionResult;
  }

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

  void _removeDataFromLocalStorage() {
    _commit(
      () async {
        await sharedPreferences!.remove(kTasks);
      },
      mustNotify: false,
    );
  }

  @override
  Future<Task> createTask(String title, String description) {
    return _commit<Future<Task>>(() async {
      final Task task = Task(
        id: _uuid.v4(),
        title: title,
        description: description,
      );
      _tasks.add(task);
      return task;
    });
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    _removeDataFromLocalStorage();
    notifyListeners();
  }

  @override
  Future<Task> editTask(String id, String title, String description) {
    return _commit<Future<Task>>(() async {
      final Task taskFound = _findTaskById(id);
      taskFound.title = title;
      taskFound.description = description;
      return taskFound;
    });
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return allTasks;
  }

  @override
  Future<void> toggleTaskCompletion(String id) {
    return _commit<Future<void>>(() async {
      final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
      taskFound.toggleDone();
    });
  }
}
