import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/core/custom_components/custom_button.dart';
import 'package:gehc_assignment/core/custom_components/custom_textfield.dart';
import 'package:gehc_assignment/domain/login_repository.dart';
import 'package:gehc_assignment/presentation/login/login_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gehc_assignment/presentation/home/home_page.dart';
import 'package:gehc_assignment/presentation/login/login_page.dart';


class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  group('LoginPage', () {
    late MockLoginBloc mockLoginBloc;

    setUp(() {
      mockLoginBloc = MockLoginBloc();
    });

    tearDown(() {
      mockLoginBloc.close();
    });

    testWidgets('renders LoginPage', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenReturn(LoginInitial());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      expect(find.byType(GEHCCustomTextField), findsNWidgets(2));
      expect(find.byType(GEHCCustomButton), findsOneWidget);
    });

    testWidgets('shows error message when LoginError state is emitted', (WidgetTester tester) async {
      whenListen(
        mockLoginBloc,
        Stream.fromIterable([LoginError('', '', false, false, 'Error message')]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      await tester.pump(); // Rebuild widget with new state

      expect(find.text('Error message'), findsOneWidget);
    });

    testWidgets('navigates to HomePage when LoginSuccess state is emitted', (WidgetTester tester) async {
      whenListen(
        mockLoginBloc,
        Stream.fromIterable([LoginSuccess()]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      await tester.pumpAndSettle(); // Wait for navigation to complete

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('shows loading overlay when Loading state is emitted', (WidgetTester tester) async {
      whenListen(
        mockLoginBloc,
        Stream.fromIterable([Loading('', '', false, false)]),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      await tester.pump(); // Rebuild widget with new state

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('enables login button when both email and password are valid', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenReturn(FieldValidationState('test@example.com', 'password123', true, false));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      final loginButton = find.byType(GEHCCustomButton);
      expect(tester.widget<GEHCCustomButton>(loginButton).isEnabled, true);
    });

    testWidgets('disables login button when email or password is invalid', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenReturn(FieldValidationState('', 'password123', false, false));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginBloc>(
            create: (_) => mockLoginBloc,
            child: const LoginPage(),
          ),
        ),
      );

      final loginButton = find.byType(GEHCCustomButton);
      expect(tester.widget<GEHCCustomButton>(loginButton).isEnabled, false);
    });
  });
}