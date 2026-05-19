class EditTodoParam {
  final String id;
  final String title;
  final String description;
  final String? deadline;

  EditTodoParam({
    required this.id,
    required this.title,
    required this.description,
    this.deadline,
  });
}