
import 'package:todo_march26/todo_details/domain/entities/edit_todo_param.dart';

abstract class BaseDetailsRepo{
  Future<String> editTodo(EditTodoParam todo);
}