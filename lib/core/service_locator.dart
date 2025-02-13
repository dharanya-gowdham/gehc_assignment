import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../data_source/login_service.dart';
import '../domain/login_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    return dio;
  });

  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(getIt<LoginService>()));
}