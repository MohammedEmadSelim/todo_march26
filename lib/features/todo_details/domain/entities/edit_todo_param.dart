// class EditTodoParam {
//   final String id;
//   final String title;
//   final String des;
//   final String deadline;

//   EditTodoParam({required this.id, required this.title, required this.des, required this.deadline});
// }
import 'package:image_picker/image_picker.dart';

class EditTodoParam {
  final String id;
  final String title;
  final String des;
  final String deadline;
  final XFile? image; // 👈 المتغير الجديد للصورة
  final bool? imageRemoved; // 👈 المتغير الجديد لمعرفة هل المستخدم مسح الصورة ولا لأ

  EditTodoParam({
    required this.id,
    required this.title,
    required this.des,
    required this.deadline,
    this.image,
    this.imageRemoved = false, // اديناها قيمة افتراضية بـ false
  });
}