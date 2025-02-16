import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/presentation/login/login_bloc.dart';

void main() {
  group('LoginEvent', () {
    test('EmailChanged supports value equality', () {
      expect(
        const EmailChanged('test@example.com'),
        const EmailChanged('test@example.com'),
      );
    });

    test('PasswordChanged supports value equality', () {
      expect(
        const PasswordChanged('password123'),
        const PasswordChanged('password123'),
      );
    });

    test('LoginSubmitted supports value equality', () {
      expect(
         LoginSubmitted(),
         LoginSubmitted(),
      );
    });

    test('Login supports value equality', () {
      expect(
        const Login('test@example.com', 'password123'),
        const Login('test@example.com', 'password123'),
      );
    });

    test('props are correct for EmailChanged', () {
      expect(
        const EmailChanged('test@example.com').props,
        ['test@example.com'],
      );
    });

    test('props are correct for PasswordChanged', () {
      expect(
        const PasswordChanged('password123').props,
        ['password123'],
      );
    });

    test('props are correct for Login', () {
      expect(
        const Login('test@example.com', 'password123').props,
        ['test@example.com', 'password123'],
      );
    });
  });
}