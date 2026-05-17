import 'package:todo_march26/features/home/data/models/todo_model.dart';
import 'package:todo_march26/features/home/domain/entity/todo_param.dart';

abstract class BaseHomeRepository {
  Future<String> createTodo(CreateTodoParam todo);
  Future<List<TodoModel>> getTodos();
}