import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_march26/feature/home/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity{
  final String? id;
  final String title;
  final String description;
  final String? deadline;
  final DateTime createdAt;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    this.deadline,
    required this.createdAt,
  }) : super(deadline: deadline, description: description, title: title, createdAt: createdAt);

  factory TodoModel.fromJson(Map<String, dynamic> json){
    return TodoModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      deadline: json['deadline'] ?? '',
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}