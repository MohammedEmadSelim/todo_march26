
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';

class TodoModel extends TodoEntity {
  final String title;
  final String description;
  final String image;
  final String deadline;

  TodoModel({
    required this.title,
    required this.description,
    required this.image,
    required this.deadline,
  }) : super(deadline: deadline, des: description, title: title, image: image);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }
}
