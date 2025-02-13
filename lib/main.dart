import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gehc_assignment/core/service_locator.dart';
import 'package:gehc_assignment/domain/login_repository.dart';
import 'package:gehc_assignment/presentation/login/login_bloc.dart';
import 'package:gehc_assignment/presentation/login/login_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc(getIt<LoginRepository>())),
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
