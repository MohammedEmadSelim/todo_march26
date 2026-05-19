import 'package:todo_march26/feature/home/data/models/todo_model.dart';
import 'package:todo_march26/feature/home/domain/entities/todo_param.dart';

abstract class BaseHomeRepoistory {
  Future<String> createTodo(CreateTodoParam todo);
  Future<List<TodoModel>> getTodos();
}