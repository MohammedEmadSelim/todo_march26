
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';

abstract class BaseDetailsRepo{
  Future<String> editTodo(EditTodoParam todo);

  // new 
  Future<String> deleteTodo(String id);
}