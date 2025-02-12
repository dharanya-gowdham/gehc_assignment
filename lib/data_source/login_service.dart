import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

class LoginService {
  final Dio _dio = Dio();

  Future<Either<Map<String, dynamic>, Exception>> login(
      String email, String password) async {
    try {
      //Hardcore password for api validation
      final response =
          await _dio.post('https://dummyjson.com/auth/login', data: {
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
