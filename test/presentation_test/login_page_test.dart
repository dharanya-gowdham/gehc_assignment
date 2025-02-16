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

class MockLoginRepository extends Mock implements LoginRepository {}

class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  group('LoginPage', () {
    late MockLoginBloc mockLoginBloc;

    setUp(() {
      mockLoginBloc = MockLoginBloc();
      whenListen(
        mockLoginBloc,
        //For simulating states over time eg:  Stream.fromIterable([LoginInitial(), Loading()]),
        Stream.fromIterable([LoginInitial()]),
        initialState: LoginInitial(),
      );
    });

    tearDown(() {
      mockLoginBloc.close();
    });

    testWidgets('renders LoginPage', (WidgetTester tester) async {
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
      // wait for all the animations and navigations to complete. Here, navigation to HomePage is running as we set the bloc state to LoginSuccess.
      await tester.pumpAndSettle();
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

      // Rebuild widget with new state
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

  });
}