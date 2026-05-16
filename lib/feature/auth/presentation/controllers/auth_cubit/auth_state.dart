part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure(this.message);
}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}

final class AuthSignUpFailure extends AuthState {
  final String message;

  AuthSignUpFailure(this.message);
}

final class AuthSendResetEmailLoading extends AuthState {}

final class AuthSendResetEmailSuccess extends AuthState {}

final class AuthSendResetEmailFailure extends AuthState {
  final String message;

  AuthSendResetEmailFailure(this.message);
}

final class AuthVerifyResetCodeLoading extends AuthState {}

final class AuthVerifyResetCodeSuccess extends AuthState {
  final String code;

  AuthVerifyResetCodeSuccess(this.code);
}

final class AuthVerifyResetCodeFailure extends AuthState {
  final String message;

  AuthVerifyResetCodeFailure(this.message);
}

final class AuthConfirmPasswordLoading extends AuthState {}

final class AuthConfirmPasswordSuccess extends AuthState {}

final class AuthConfirmPasswordFailure extends AuthState {
  final String message;

  AuthConfirmPasswordFailure(this.message);
}

final class AuthSignOutLoading extends AuthState {}

final class AuthSignOutSuccess extends AuthState {}

final class AuthSignOutFailure extends AuthState {
  final String message;

  AuthSignOutFailure(this.message);
}