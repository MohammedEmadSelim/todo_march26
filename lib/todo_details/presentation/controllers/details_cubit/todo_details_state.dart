part of 'todo_details_cubit.dart';

@immutable
sealed class TodoDetailsState {}

final class TodoDetailsInitial extends TodoDetailsState {}

final class TodoDetailsLoading extends TodoDetailsState {}
final class TodoDetailsSuccess extends TodoDetailsState {}
final class TodoDetailsFailure extends TodoDetailsState {
  final String message;

  TodoDetailsFailure(this.message);
}
