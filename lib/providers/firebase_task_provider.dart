import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../interfaces/task_provider.dart';
import '../models/task.dart';

class FirebaseTaskProvider extends ChangeNotifier implements TaskProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Task> _tasks = <Task>[];

  Task _findTaskById(String id) {
    return _tasks.firstWhere((Task task) => task.id == id);
  }

  @override
  Future<Task> createTask(String title, String description) async {
    final DocumentReference<Map<String, dynamic>> doc =
        await _firestore.collection('tasks').add(<String, dynamic>{
      'title': title,
      'description': description,
      'completed': false,
      'lastUpdated': DateTime.now(),
    });
    final Task task = Task(
      id: doc.id,
      title: title,
      description: description,
    );
    _tasks.add(task);
    notifyListeners();
    return task;
  }

  @override
  Future<void> deleteTask(String id) async {
    final Task taskFound = _findTaskById(id);
    _tasks.remove(taskFound);
    notifyListeners();
    await _firestore.collection('tasks').doc(id).delete();
  }

  @override
  Future<Task> editTask(String id, String title, String description) async {
    final Task taskFound = _findTaskById(id);
    taskFound.title = title;
    taskFound.description = description;
    taskFound.lastUpdated = DateTime.now();
    notifyListeners();
    await _firestore.collection('tasks').doc(id).update(<String, dynamic>{
      'title': title,
      'description': description,
      'lastUpdated': DateTime.now(),
    });
    return taskFound;
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('tasks').get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    _tasks = docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Map<String, dynamic> data = doc.data();
      return Task(
        id: doc.id,
        title: data['title'],
        description: data['description'],
        completed: data['completed'],
      );
    }).toList();
    return _tasks;
  }

  @override
  Future<void> toggleTaskCompletion(String id) async {
    final Task taskFound = _findTaskById(id);
    taskFound.toggleDone();
    notifyListeners();
    await _firestore.collection('tasks').doc(id).update(<String, dynamic>{
      'completed': taskFound.completed,
    });
  }
}
