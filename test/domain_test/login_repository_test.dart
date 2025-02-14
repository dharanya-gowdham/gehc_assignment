import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/data_source/login_service.dart';
import 'package:gehc_assignment/data_source/secure_storage.dart';
import 'package:gehc_assignment/domain/login_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

// Generate mock classes
@GenerateMocks([LoginService, SecureStorage])
void main() {
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLoginService mockLoginService;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockLoginService = MockLoginService();
    mockSecureStorage = MockSecureStorage();
    loginRepositoryImpl =
        LoginRepositoryImpl(mockLoginService, mockSecureStorage);
  });

  test('login method stores access token on successful login', () async {
    const email = 'emilys@example.com';
    const password = 'emilyspass';
    final responseData = {
      "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
      "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    };

    when(mockLoginService.login(email, password))
        .thenAnswer((_) async => Left(responseData));

    final result = await loginRepositoryImpl.login(email, password);
    verify(mockSecureStorage.storeAccessToken(responseData["accessToken"])).called(1);

    expect(result.isLeft(), isTrue);
  });

  test('login returns exception message on failed login', () async {
    const email = 'test@example.com';
    const password = 'password';
    const exceptionMessage = 'Login failed';

    when(mockLoginService.login(email, password)).thenAnswer(
      (_) async => Right(Exception(exceptionMessage)),
    );

    final result = await loginRepositoryImpl.login(email, password);

    verifyNever(mockSecureStorage.storeAccessToken(any));

    expect(result.isRight(), isTrue);
    expect(result.fold((data) => null, (error) => error.toString().split(': ').last), exceptionMessage);
  });
}
