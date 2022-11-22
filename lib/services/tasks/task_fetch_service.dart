import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../../models/task.dart';

class TaskFetchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final http.Client _client = http.Client();
  static const String url = 'http://10.0.2.2:3000/tasks';

  Future<List<Task>> getAllTasksFromApi() async {
    try {
      final http.Response response = await _client.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        final List<Task> tasks = List<Task>.from(
          data.map((dynamic model) => Task.fromMap(model)),
        );
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Failed to load tasks');
    }
  }

  Future<List<Task>> getAllTasksFromFirebase() async {
    List<Task> tasks = <Task>[];
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('tasks').get();
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
        querySnapshot.docs;
    tasks = docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final Map<String, dynamic> data = doc.data();
      return Task(
        id: doc.id,
        title: data['title'],
        description: data['description'],
        completed: data['completed'],
      );
    }).toList();
    return tasks;
  }
}
