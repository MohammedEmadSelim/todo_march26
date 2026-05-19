class CreateTodoParam {
  final String title;
  final String description;
  final String? deadline;
  CreateTodoParam({
    required this.title,
    required this.description,
    this.deadline,
  });
}