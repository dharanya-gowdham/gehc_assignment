import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void>? storeAccessToken(String token);
}

class SecureStorageImpl implements SecureStorage {

  final FlutterSecureStorage secureStorage;
  SecureStorageImpl(this.secureStorage);

  @override
  Future<void>? storeAccessToken(String token) async {
    await secureStorage.write(key: 'accessToken', value: token);
  }
}
