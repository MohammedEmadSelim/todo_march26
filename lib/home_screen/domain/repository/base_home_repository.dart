import 'package:todo_march26/home_screen/data/models/todo_model.dart';
import 'package:todo_march26/home_screen/domain/entites/todo_param.dart';

abstract class BaseHomeRepository {
  Future<String> createTodo(CreateTodoParam todo);
  Future<List<TodoModel>> getTodos();
}