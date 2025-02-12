part of 'login_bloc.dart';

sealed class LoginState {
  final String email;
  final String password;
  final bool enableButton;
  final bool showError;

  const LoginState(
      this.email, this.password, this.enableButton, this.showError);
}

final class LoginInitial extends LoginState {
  LoginInitial() : super('', '', false, false);
}

final class FieldValidationState extends LoginState {
  FieldValidationState(
      super.email, super.password, super.enableButton, super.showError);
}

final class Loading extends LoginState {
  Loading(super.email, super.password, super.enableButton, super.showError);
}

final class LoginSuccess extends LoginState {
  LoginSuccess() : super('', '', false, false);
}

final class LoginError extends LoginState {
  final String errorMessage;

  LoginError(super.email, super.password, super.enableButton, super.showError,
      this.errorMessage);
}
