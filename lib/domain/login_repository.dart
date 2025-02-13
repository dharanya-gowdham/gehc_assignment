import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gehc_assignment/core/secure_storage.dart';
import 'package:gehc_assignment/data_source/login_service.dart';

abstract class LoginRepository {
  Future<Either<bool, String>> login(String email, String password);
}

class LoginRepositoryImpl implements LoginRepository {
  final LoginService loginService;
  LoginRepositoryImpl(this.loginService);

  @override
  Future<Either<bool, String>> login(String email, String password) async {
    final result = await loginService.login(email, password);
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
