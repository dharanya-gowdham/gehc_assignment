import 'package:dartz/dartz.dart';
import 'package:gehc_assignment/data_source/login_service.dart';

import '../core/secure_storage.dart';

abstract class LoginRepository {
  Future<Either<bool, String>> login(String email, String password);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginService loginService;
  final SecureStorage secureStorage;

  LoginRepositoryImpl(this.loginService, this.secureStorage);

  @override
  Future<Either<bool, String>> login(String email, String password) async {
    final result = await loginService.login(email, password);
    return result.fold(
      (data) async {
        final accessToken = data["accessToken"];
        await secureStorage.storeAccessToken(accessToken);
        return Left(true);
      },
      (exception) => Right(exception.toString()),
    );
  }
}
