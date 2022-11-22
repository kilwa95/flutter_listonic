import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class TaskDeleteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final http.Client _client = http.Client();
  static const String url = 'http://10.0.2.2:3000/tasks';

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

  Future<void> deleteTaskFromFirebase(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete tasks');
    }
  }
}
