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

