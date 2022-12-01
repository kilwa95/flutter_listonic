import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/task.dart';

class TaskFireBaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  Future<void> deleteTaskFromFirebase(String id) async {
    try {
      await _firestore.collection('tasks').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete tasks');
    }
  }
}
