
// import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';

// class TodoModel extends TodoEntity {
//   final String title;
//   final String description;
//   final String image;
//   final String deadline;

//   TodoModel({
//     required this.title,
//     required this.description,
//     required this.image,
//     required this.deadline,
//   }) : super(deadline: deadline, des: description, title: title, image: image);

//   factory TodoModel.fromJson(Map<String, dynamic> json) {
//     return TodoModel(
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       image: json['image'] ?? '',
//       deadline: json['deadline'] ?? '',
//     );
//   }
// }
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';

class TodoModel extends TodoEntity {
  // 🧹 شيلنا المتغيرات المتكررة لأنها موجودة بالفعل في TodoEntity وهنورثها

  TodoModel({
    required String id,
    required String title,
    required String description,
    required String image,
    required String deadline,
  }) : super(
          id: id, // 👈 بنمرر الـ id للـ Entity
          deadline: deadline,
          des: description,
          title: title,
          image: image,
        );

  // 👈 ضفنا String id كـ parameter عشان ناخده من الوثيقة (Document) بتاعت فايربيس
  factory TodoModel.fromJson(Map<String, dynamic> json, String id) {
    return TodoModel(
      id: id, // 👈 ربطنا الـ id
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      deadline: json['deadline'] ?? '',
    );
  }
}
