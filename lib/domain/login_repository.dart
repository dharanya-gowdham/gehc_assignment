import 'package:dartz/dartz.dart';
import 'package:gehc_assignment/core/secure_storage.dart';
import 'package:gehc_assignment/data_source/login_service.dart';

class LoginRepository {
  final LoginService _loginService = LoginService();

  Future<Either<bool, String>> login(String email, String password) async {
    final result = await _loginService.login(email, password);
    return result.fold(
      (data) async {
        final accessToken = data["accessToken"];
        await SecureStorage().storeAccessToken(accessToken);
        return Left(true);
      },
      (exception) => Right(exception.toString()),
    );
  }
}
