class TodoEntity {
  final String title;
  final String des;
  final String deadline;
  final String? image;

  TodoEntity({
    required this.title,
    required this.des,
    required this.deadline,
    this.image,
  });
}