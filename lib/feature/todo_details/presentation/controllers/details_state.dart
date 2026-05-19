part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {}

final class DetailsFailure extends DetailsState {
  final String msg;

  DetailsFailure(this.msg);
}

final class DetailsDeleteLoading extends DetailsState {}

final class DetailsDeleteSuccess extends DetailsState {}

final class DetailsDeleteFailure extends DetailsState {
  final String msg;

  DetailsDeleteFailure(this.msg);
}
