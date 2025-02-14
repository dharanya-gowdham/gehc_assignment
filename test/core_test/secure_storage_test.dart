import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:gehc_assignment/core/secure_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorageImpl secureStorage;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
    setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorageImpl(mockFlutterSecureStorage);
  });

  // test('storeAccessToken method stores the token', () async {
  //   const token = 'testAccessToken';
  //
  //   when(mockFlutterSecureStorage.write(key: 'accessToken', value: token))
  //       .thenAnswer((_) async => Future.value());
  //   await secureStorage.storeAccessToken(token);
  //   verify(mockFlutterSecureStorage.write(key: 'accessToken', value: token)).called(1);
  // });
}