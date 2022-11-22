import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../../models/task.dart';

class TaskSaveService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final http.Client _client = http.Client();
  static const String url = 'http://10.0.2.2:3000/tasks';

  Future<Task> createTaskFromApi(String title, String description) async {
    try {
      final http.Response response = await _client.post(
        Uri.parse(url),
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
        throw Exception('Failed to create tasks');
      }
    } catch (e) {
      throw Exception('Failed to create tasks');
    }
  }

  Future<String> createTaskFromFirebase(
    String title,
    String description,
  ) async {
    try {
      final DocumentReference<Map<String, dynamic>> doc =
          await _firestore.collection('tasks').add(<String, dynamic>{
        'title': title,
        'description': description,
        'completed': false,
        'lastUpdated': DateTime.now(),
      });
      return doc.id;
    } catch (e) {
      throw Exception('Failed to create tasks');
    }
  }
}
