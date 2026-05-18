import 'package:image_picker/image_picker.dart';

class CreateTodoParam {
  final String title;
  final String description;
  final String deadline;
  final XFile? image;

  CreateTodoParam({
    required this.title,
    required this.description,
    required this.deadline,
    this.image,
  });
}