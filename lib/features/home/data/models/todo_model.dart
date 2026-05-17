import 'package:todo_march26/features/home/domain/entity/todo_entity.dart';

class TodoModel extends TodoEntity {

  final String title;
  final String desc;
  final String image;
  final String deadline;

  TodoModel({
    required this.title,
    required this.desc,
    required this.image,
    required this.deadline,
  }) : super(deadline: deadline, desc: desc, title: title, image: image);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      image: json['image'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }
}