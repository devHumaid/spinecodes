import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String name;
  String description;
  String deadline;
  String priority;
  String category;
  String status;
  Timestamp createdAt;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.deadline,
    required this.priority,
    required this.category,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'deadline': deadline,
      'priority': priority,
      'category': category,
      'status': status,
      'createdAt': createdAt,
    };
  }

  factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      deadline: map['deadline'] ?? '',
      priority: map['priority'] ?? '',
      category: map['category'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }
}
