import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/task.dart';

class TaskApiService {
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

  Future<void> deleteTaskFromApi(String id) async {
    try {
      await _client.delete(
        Uri.parse('$url/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      throw Exception('Failed to delete tasks');
    }
  }

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
}
