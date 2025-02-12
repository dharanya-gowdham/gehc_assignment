import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> storeAccessToken(String token) async {
    await _secureStorage.write(key: 'accessToken', value: token);
  }
}
