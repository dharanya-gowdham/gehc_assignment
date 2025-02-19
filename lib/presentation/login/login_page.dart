import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gehc_assignment/presentation/home/home_page.dart';

import '../../core/custom_components/custom_button.dart';
import '../../core/custom_components/custom_loading.dart';
import '../../core/custom_components/custom_textfield.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
      if (state is LoginSuccess) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if (state is LoginError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errorMessage)));
      }
    }, builder: (BuildContext context, state) {
      return LoadingOverlayWidget(
        isLoading: state is Loading,
        child: Scaffold(
          appBar: AppBar(title: Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GEHCCustomTextField(
                  key: ValueKey('email'),
                  controller: emailController,
                  labelText: 'Email',
                  fieldType: FieldType.email,
                  showError: state.showError,
                  onChanged: (value) {
                    context.read<LoginBloc>().add(EmailChanged(value));
                  },
                ),
                SizedBox(height: 20),
                GEHCCustomTextField(
                  key: ValueKey(FieldType.password),
                  controller: passwordController,
                  labelText: 'Password',
                  fieldType: FieldType.password,
                  showError: state.showError,
                  onChanged: (value) {
                    context.read<LoginBloc>().add(PasswordChanged(value));
                  },
                ),
                SizedBox(height: 20),
                GEHCCustomButton(
                  onPressed: () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                    context.read<LoginBloc>().add(
                        Login(emailController.text, passwordController.text));
                  },
                  text: 'Login',
                  isEnabled: state.enableButton,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
