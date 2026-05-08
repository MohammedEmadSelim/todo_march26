part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthRegisterLoading extends AuthState {}
final class AuthRegisterSuccess extends AuthState {}
final class AuthRegisterFailure extends AuthState {
  final String message;

  AuthRegisterFailure(this.message);
}