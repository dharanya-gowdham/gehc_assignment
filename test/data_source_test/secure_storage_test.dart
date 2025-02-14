import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:gehc_assignment/data_source/secure_storage.dart';

import 'secure_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])

void main() {
  late SecureStorageImpl secureStorageImpl;
  late MockFlutterSecureStorage mockFlutterSecureStorage;
  setUp(() {
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    secureStorageImpl = SecureStorageImpl(mockFlutterSecureStorage);
  });

  test('storeAccessToken method stores the token', () async {
    const token = 'testAccessToken';

    when(mockFlutterSecureStorage.write(key: 'accessToken', value: token))
        .thenAnswer((_) async => Future.value(null));
    await secureStorageImpl.storeAccessToken(token);
    verify(mockFlutterSecureStorage.write(key: 'accessToken', value: token)).called(1);
  });
}