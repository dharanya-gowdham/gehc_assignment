part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final String email;
  final String password;
  final bool enableButton;
  final bool showError;

  const LoginState(
      this.email, this.password, this.enableButton, this.showError);

  @override
  List<Object?> get props => [email, password, enableButton, showError];
}

final class LoginInitial extends LoginState {
  const LoginInitial() : super('', '', false, false);
}

final class FieldValidationState extends LoginState {
  const FieldValidationState(
      super.email, super.password, super.enableButton, super.showError);
}

final class Loading extends LoginState {
  const Loading(super.email, super.password, super.enableButton, super.showError);
}

final class LoginSuccess extends LoginState {
  const LoginSuccess() : super('', '', false, false);
}

final class LoginError extends LoginState {
  final String errorMessage;

  const LoginError(super.email, super.password, super.enableButton, super.showError,
      this.errorMessage);
}
