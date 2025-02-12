part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged(this.email);
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged(this.password);
}

class LoginSubmitted extends LoginEvent {}

class Login extends LoginEvent {
  final String email;
  final String password;

  const Login(this.email, this.password);
}
