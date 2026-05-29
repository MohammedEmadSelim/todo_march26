import 'package:todo_march26/features/todo_details/domain/entities/delete_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';


abstract class BaseDetailsRepository {
  Future<String> editTodo(EditTodoParam todo);
  Future<String> deleteTodo(DeleteTodoParam todo);
}