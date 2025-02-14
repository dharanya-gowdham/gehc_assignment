import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gehc_assignment/core/secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../data_source/login_service.dart';
import '../domain/login_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<FlutterSecureStorage>(() {
    final flutterSecureStorage = FlutterSecureStorage();
    return flutterSecureStorage;
  });
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorageImpl(getIt<FlutterSecureStorage>()));


  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    return dio;
  });

  getIt.registerLazySingleton<LoginService>(() => LoginServiceImpl(getIt<Dio>()));
  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(getIt<LoginService>(), getIt<SecureStorage>()));


}