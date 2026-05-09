part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeCreateTodoLoading extends HomeState {}
final class HomeCreateTodoSuccess extends HomeState {}
final class HomeCreateTodoFailure extends HomeState {
  final String message;

  HomeCreateTodoFailure(this.message);
}

final class HomeFetchTodosLoading extends HomeState {}
final class HomeFetchTodosSuccess extends HomeState {
  final List<TodoEntity> todos;

  HomeFetchTodosSuccess(this.todos);
}
final class HomeFetchTodosFailure extends HomeState {
  final String message;

  HomeFetchTodosFailure(this.message);
}
