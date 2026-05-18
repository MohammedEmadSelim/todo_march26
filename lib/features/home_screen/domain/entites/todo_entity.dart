// class TodoEntity {
//   final String title;
//   final String des;
//   final String deadline;
//   final String? image;

//   TodoEntity({
//     required this.title,
//     required this.des,
//     required this.deadline,
//      this.image,
//   });
// }
class TodoEntity {
  final String id; // 👈 ضفنا الـ id هنا
  final String title;
  final String des;
  final String deadline;
  final String? image;

  TodoEntity({
    required this.id, // 👈 بقى مطلوب
    required this.title,
    required this.des,
    required this.deadline,
    this.image,
  });
}
