import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../../models/task.dart';

class TaskUpdateService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final http.Client _client = http.Client();
  static const String url = 'http://10.0.2.2:3000/tasks';

  Future<Task> editTaskFromApi(
    String id,
    String title,
    String description,
  ) async {
    try {
      final http.Response response = await _client.put(
        Uri.parse('$url/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{'title': title, 'description': description},
        ),
      );
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.body);
        return Task.fromMap(data);
      } else {
        throw Exception('Failed to edit tasks');
      }
    } catch (e) {
      throw Exception('Failed to edit tasks');
    }
  }

  Future<void> editTaskFromFirebase(
    String id,
    String title,
    String description,
  ) async {
    try {
      await _firestore.collection('tasks').doc(id).update(<String, dynamic>{
        'title': title,
        'description': description,
        'lastUpdated': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to edit tasks');
    }
  }

  Future<void> toggleTaskCompletionFromApi(String id) async {
    try {
      await _client.patch(
        Uri.parse('$url/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      throw Exception('Failed to toggle tasks');
    }
  }

  Future<void> toggleTaskCompletionFromFirebase(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection('tasks').doc(id).get();
      await _firestore.collection('tasks').doc(id).update(<String, dynamic>{
        'completed': !doc.data()!['completed'],
        'lastUpdated': DateTime.now(),
      });
    } catch (e) {
      throw Exception('Failed to toggle tasks');
    }
  }
}
