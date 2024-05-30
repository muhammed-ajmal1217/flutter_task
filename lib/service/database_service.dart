import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/model/task_model.dart';

class DataBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Stream<List<TaskModel>> getDatas() {
    try {
      return firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('tasks')
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return TaskModel.fromJson(doc);
        }).toList();
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> compltedTasks(String taskId) async {
    try {
      DocumentSnapshot taskSnapshot = await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('tasks')
          .doc(taskId)
          .get();
      bool currentStatus = taskSnapshot['completed'];
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('tasks')
          .doc(taskId)
          .update({'completed': !currentStatus});
    } catch (e) {
          throw Exception('toggling error:  $e');
    }
  }

  Future<void> addTask({
    String? title,
    String? description,
    DateTime? dateTime,
    Duration? estimatedTime,
  }) async {
    try {
      int? estimatedTimeMilliseconds = estimatedTime?.inMilliseconds;
      TaskModel task = TaskModel(
        id: auth.currentUser?.uid,
        title: title,
        description: description,
        dateTime: dateTime,
        estimatedTime: estimatedTimeMilliseconds,
      );
      await firestore
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection('tasks')
          .doc()
          .set(task.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
  Future<void> updateTask({
  required String taskId,
  String? title,
  String? description,
  DateTime? dateTime,
  Duration? estimatedTime,
}) async {
  try {
    int? estimatedTimeMilliseconds = estimatedTime?.inMilliseconds;
    TaskModel task = TaskModel(
      id: taskId, 
      title: title,
      description: description,
      dateTime: dateTime,
      estimatedTime: estimatedTimeMilliseconds,
    );
    await firestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('tasks')
        .doc(taskId) 
        .update(task.toJson()); 
  } catch (e) {
    throw Exception(e);
  }
}

  Future<void> deleteTask(String taskId) async {
  try {
    await firestore
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  } catch (e) {
    throw Exception(e);
  }
}

}
