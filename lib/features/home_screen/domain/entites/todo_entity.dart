class TodoEntity {
  final String? id;
  final String title;
  final String description;
  final String? deadline;
  final DateTime createdAt;

  TodoEntity({
    this.id,
    required this.title,
    required this.description,
    this.deadline,
    required this.createdAt,
  });
}