import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:gehc_assignment/data_source/api_urls.dart';

abstract class LoginService {
  Future<Either<Map<String, dynamic>, Exception>> login(String email, String password);
}

class LoginServiceImpl implements LoginService{
  final Dio dio;
  LoginServiceImpl(this.dio);

  @override
  Future<Either<Map<String, dynamic>, Exception>> login(
      String email, String password) async {
    try {
      //Hardcore password for api validation
      final response =
          await dio.post(ApiUrls.loginApi, data: {
        'username': email.substring(0, email.indexOf('@')),
        'password': 'emilyspass',
      });
      if (response.statusCode == 200) {
        return Left(response.data);
      } else {
        return Right(Exception(response.data["message"]));
      }
    } catch (e) {
      return Right(Exception(e.toString()));
    }
  }
}
