class TodoEntity {
  final String title;
  final String desc;
  final String deadline;
  final String? image;

  TodoEntity({
    required this.title,
    required this.desc,
    required this.deadline,
    this.image,
  });
}