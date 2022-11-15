import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listonic/models/task.dart';
import 'package:flutter_listonic/services/task_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/shared_pref_helper.dart';
import 'in_memory_provider.dart';

class LocalStorage extends ChangeNotifier implements TaskProvider {
  LocalStorage() {
    SharedPreferencesHelper.init().then((_) async {
      sharedPreferences = SharedPreferencesHelper.instance;

      if (!sharedPreferences!.containsKey('tasks')) {
        await sharedPreferences!.setStringList('tasks', const <String>[]);
      }
      _loadDataFromLocalStorage();
      notifyListeners();
    });
  }

  List<Task> _tasks = <Task>[];

  SharedPreferences? sharedPreferences;

  UnmodifiableListView<Task> get allTasks => UnmodifiableListView<Task>(_tasks);

  void _loadDataFromLocalStorage() {
    final List<String>? spTasks = sharedPreferences!.getStringList('tasks');
    if (spTasks != null) {
      _tasks = spTasks
          .map((String item) => Task.fromMap(json.decode(item)))
          .toList();
    }
  }

  void _saveDataToLocalStorage() {
    final List<String> spList =
        _tasks.map((Task item) => json.encode(item.toMap())).toList();
    sharedPreferences!.setStringList('tasks', spList);
  }

  void _removeDataFromLocalStorage() {
    sharedPreferences!.remove('tasks');
    _saveDataToLocalStorage();
  }

  @override
  Future<Task> createTask(String title, String description) async {
    final Task task = Task(
      id: uuid.v1(),
      title: title,
      description: description,
    );
    _tasks.add(task);
    _saveDataToLocalStorage();
    notifyListeners();
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    _tasks.remove(taskFound);
    _removeDataFromLocalStorage();
    notifyListeners();
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    taskFound.title = title;
    taskFound.description = description;
    notifyListeners();
    _saveDataToLocalStorage();
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    return allTasks;
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _tasks.firstWhere((Task task) => task.id == id);
    taskFound.toggleDone();
    _saveDataToLocalStorage();
    notifyListeners();
  }
}
