part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeFetchTodoLoading extends HomeState {}

final class HomeFetchTodoSuccess extends HomeState {
  final List<TodoEntity> todos;

  HomeFetchTodoSuccess(this.todos);
}

final class HomeFetchTodoFailure extends HomeState {
  final String message;

  HomeFetchTodoFailure(this.message);
}

final class HomeCreateTodoLoading extends HomeState {}

final class HomeCreateTodoSuccess extends HomeState {}

final class HomeCreateTodoFailure extends HomeState {
  final String message;

  HomeCreateTodoFailure(this.message);
}