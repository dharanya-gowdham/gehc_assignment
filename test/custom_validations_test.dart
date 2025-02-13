import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/core/custom_validations.dart';

void main() {
  group('CustomValidations', () {
    final validations = CustomValidations();

    group('EmailValidations', () {
      test('emailValidation returns error for empty email', () {
        expect(validations.emailValidation(''), 'Email cannot be empty');
      });

      test('emailValidation returns error for invalid email', () {
        expect(validations.emailValidation('emilys'),
            'Enter a valid email address');
      });

      test('emailValidation returns null for valid email', () {
        expect(validations.emailValidation('emilys@gmail.com'), null);
      });
    });

    group('PasswordValidations', () {
      test('passwordValidation returns error for empty password', () {
        expect(validations.passwordValidation(''), 'Password cannot be empty');
      });

      test('passwordValidation returns error for short password', () {
        expect(validations.passwordValidation('emilys'),
            'Password must be at least 8 characters long');
      });

      test(
          'passwordValidation returns error for password without uppercase letter',
          () {
        expect(validations.passwordValidation('emilys@123'),
            'Password must contain at least one uppercase letter');
      });

      test(
          'passwordValidation returns error for password without lowercase letter',
          () {
        expect(validations.passwordValidation('EMILYS@123'),
            'Password must contain at least one lowercase letter');
      });

      test('passwordValidation returns error for password without number', () {
        expect(validations.passwordValidation('Emilyss@'),
            'Password must contain at least one number');
      });

      test(
          'passwordValidation returns error for password without special character',
          () {
        expect(validations.passwordValidation('Emilys123'),
            'Password must contain at least one special character');
      });

      test('passwordValidation returns null for valid password', () {
        expect(validations.passwordValidation('Emilys@123'), null);
      });
    });
  });
}
