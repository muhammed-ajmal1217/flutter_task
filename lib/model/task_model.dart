import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? dateTime;
  final int? estimatedTime; 
  final bool completed;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.dateTime,
    this.estimatedTime,
    this.completed =false, 
  });

  factory TaskModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    return TaskModel(
      id: doc.id,
      title: data?['title'] ?? '',
      description: data?['description'] ?? '',
      dateTime: (data?['date_time'] as Timestamp?)?.toDate(),
      estimatedTime: data?['estimated_time'] ?? 0, 
      completed: data?['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'title': title,
      'description': description,
      'date_time': dateTime,
      'estimated_time': estimatedTime, 
      'completed': completed,
    };
  }
}
