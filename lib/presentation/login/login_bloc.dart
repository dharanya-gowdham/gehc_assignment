import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gehc_assignment/core/custom_validations.dart';

import '../../domain/login_repository.dart';
import 'login_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository = LoginRepository();

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(loginSubmitted);
    on<EmailChanged>(emailChanged);
    on<PasswordChanged>(passwordChanged);
    on<Login>(login);
  }

  Future<void> login(LoginEvent event, Emitter<LoginState> emit) async {
    if (CustomValidations().emailValidation(state.email) == null &&
        CustomValidations().passwordValidation(state.password) == null) {
      emit(Loading(
          state.email, state.password, state.enableButton, state.showError));
      final result = await _loginRepository.login(state.email, state.password);
      result.fold(
          (data) => emit(LoginSuccess()),
          (exception) => emit(LoginError(state.email, state.password,
              state.enableButton, state.showError, exception)));
    }
  }

  Future<void> loginSubmitted(
      LoginEvent event, Emitter<LoginState> emit) async {
    emit(FieldValidationState(
        state.email, state.password, state.enableButton, true));
  }

  Future<void> emailChanged(
      EmailChanged event, Emitter<LoginState> emit) async {
    emit(FieldValidationState(event.email, state.password,
        event.email.isNotEmpty && state.password.isNotEmpty, state.showError));
  }

  Future<void> passwordChanged(
      PasswordChanged event, Emitter<LoginState> emit) async {
    emit(FieldValidationState(state.email, event.password,
        state.email.isNotEmpty && event.password.isNotEmpty, state.showError));
  }
}
