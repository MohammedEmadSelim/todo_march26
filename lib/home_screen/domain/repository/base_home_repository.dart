

import 'package:todo_march26/home_screen/domain/entites/todo_param.dart';

abstract class BaseHomeRepository {
  Future<String> createTodo(CreateTodoParam todo);
}