import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/presentation/login/login_bloc.dart';

void main() {
  group('LoginState', () {
    test('LoginInitial supports value equality', () {
      expect(
        LoginInitial(),
        LoginInitial(),
      );
    });

    test('FieldValidationState supports value equality', () {
      expect(
        FieldValidationState('test@example.com', 'password@123', true, false),
        FieldValidationState('test@example.com', 'password@123', true, false),
      );
    });

    test('Loading supports value equality', () {
      expect(
        Loading('test@example.com', 'password@123', true, false),
        Loading('test@example.com', 'password@123', true, false),
      );
    });

    test('LoginSuccess supports value equality', () {
      expect(
        LoginSuccess(),
        LoginSuccess(),
      );
    });

    test('LoginError supports value equality', () {
      expect(
        LoginError('test@example.com', 'password@123', true, false, 'Failed to login'),
        LoginError('test@example.com', 'password@123', true, false, 'Failed to login'),
      );
    });

  });
}