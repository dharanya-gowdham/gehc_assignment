import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/domain/login_repository.dart';
import 'package:gehc_assignment/presentation/login/login_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([LoginRepository])

void main() {
 late LoginBloc loginBloc;
 late MockLoginRepository mockLoginRepository;

 setUp(() {
   mockLoginRepository = MockLoginRepository();
   loginBloc = LoginBloc(mockLoginRepository);
 });

 tearDown(() {
   loginBloc.close();
 });

 blocTest<LoginBloc, LoginState>(
   'emits [FieldValidationState] when EmailChanged is added',
   build: () => loginBloc,
   act: (bloc) => bloc.add(const EmailChanged('test@example.com')),
   expect: () => [
     FieldValidationState('test@example.com', '', false, false),
   ],
 );

 blocTest<LoginBloc, LoginState>(
   'emits [FieldValidationState] when PasswordChanged is added',
   build: () => loginBloc,
   act: (bloc) => bloc.add(const PasswordChanged('Password@123')),
   expect: () => [
     FieldValidationState('', 'Password@123', false, false),
   ],
 );

 blocTest<LoginBloc, LoginState>(
   'emits [FieldValidationState] with enableButton true when both email and password are valid',
   build: () => loginBloc,
   act: (bloc) {
     bloc.add(const EmailChanged('test@example.com'));
     bloc.add(const PasswordChanged('Password@123'));
   },
   expect: () => [
     FieldValidationState('test@example.com', '', false, false),
     FieldValidationState('test@example.com', 'Password@123', true, false),
   ],
 );

 blocTest<LoginBloc, LoginState>(
   'emits [FieldValidationState] with showError true when LoginSubmitted is added',
   build: () => loginBloc,
   act: (bloc) =>{
     bloc.add(const EmailChanged('test')),
     bloc.add(const PasswordChanged('Password')),
     bloc.add(LoginSubmitted())
   },
   expect: () => [
     FieldValidationState('test', '', false, false),
     FieldValidationState('test', 'Password', true, false),
     FieldValidationState('test', 'Password', true, true),
   ],
 );

 blocTest<LoginBloc, LoginState>(
   'emits [Loading, LoginSuccess] when login is successful',
   build: () {
     when(mockLoginRepository.login(any, any))
         .thenAnswer((_) async => const Left(true));
     return loginBloc;
   },
   act: (bloc) {
     bloc.add(const EmailChanged('test@example.com'));
     bloc.add(const PasswordChanged('Password@123'));
     bloc.add(const Login('test@example.com', 'Password@123'));
   },
   expect: () => [
     FieldValidationState('test@example.com', '', false, false),
     FieldValidationState('test@example.com', 'Password@123', true, false),
     Loading('test@example.com', 'Password@123', true, false),
     LoginSuccess(),
   ],
 );

 blocTest<LoginBloc, LoginState>(
   'emits [Loading, LoginError] when login fails',
   build: () {
     when(mockLoginRepository.login(any, any))
         .thenAnswer((_) async => const Right('Login fails'));
     return loginBloc;
   },
   act: (bloc) {
     bloc.add(const EmailChanged('test@example.com'));
     bloc.add(const PasswordChanged('Password@123'));
     bloc.add(const Login('test@example.com', 'Password@123'));
   },
   expect: () => [
     FieldValidationState('test@example.com', '', false, false),
     FieldValidationState('test@example.com', 'Password@123', true, false),
     Loading('test@example.com', 'Password@123', true, false),
     LoginError('test@example.com', 'Password@123', true, false, 'Login fails'),
   ],
 );

}