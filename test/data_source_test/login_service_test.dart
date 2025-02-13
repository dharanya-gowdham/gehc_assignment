import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/data_source/api_urls.dart';
import 'package:gehc_assignment/data_source/login_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {

  late LoginServiceImpl loginServiceImpl;
  late MockDio mockDio;
  late LoginService loginService;

  setUp(() {
    mockDio = MockDio();
    loginServiceImpl = LoginServiceImpl(mockDio);
  });

  RequestOptions requestOptions = RequestOptions();
  group('LoginService api', (){
    test('login returns authorization data on success', () async{
        const email = 'emilys@example.com';
        const password = 'Emily@123';
        final responseData = {
          "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
          "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
        };

        // Arrange
        when(mockDio.post(
          ApiUrls.loginApi,
          data: {
            'username': 'emilys',
            'password': 'emilyspass',
          },
        )).thenAnswer((_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: requestOptions,
        ));

        // Act
        final result = await loginServiceImpl.login(email, password);

        // Assert
        expect(result.isLeft(), isTrue);
        expect(result.fold((data) => data, (error) => null), responseData);
      });

      test('login returns exception on failure', () async {
        const email = 'test@example.com';
        const password = 'Test@123';
        final errorMessage = {'message': 'Invalid credentials'};

        // Arrange
        when(mockDio.post(
          'https://dummyjson.com/auth/login',
          data: {
            'username': 'test',
            'password': 'emilyspass',
          },
        )).thenAnswer((_) async => Response(
          data: errorMessage,
          statusCode: 400,
          requestOptions: requestOptions
        ));

        // Act
        final result = await loginServiceImpl.login(email, password);

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.fold((data) => null, (error) => error.toString()),
            contains('Invalid credentials'));
      });

      test('login returns exception on network error', () async {
        const email = 'test@example.com';
        const password = 'password';
        final exceptionMessage = 'Network error';

        // Arrange
        when(mockDio.post(
          'https://dummyjson.com/auth/login',
          data: {
            'username': 'test',
            'password': 'emilyspass',
          },
        )).thenThrow(DioException(
          requestOptions: requestOptions,
          error: exceptionMessage,
        ));

        // Act
        final result = await loginServiceImpl.login(email, password);

        // Assert
        expect(result.isRight(), isTrue);
        expect(result.fold((data) => null, (error) => error.toString()),
            contains(exceptionMessage));
      });

  });
}