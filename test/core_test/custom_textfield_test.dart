import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/core/custom_components/custom_textfield.dart';

import 'common_testable_widget.dart';

void main() {
  group('GEHCCustomTextField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    testWidgets('displays label text', (WidgetTester tester) async {
      await tester.pumpWidget(
        testableWidget(
          GEHCCustomTextField(
            controller: controller,
            labelText: 'Email',
            fieldType: FieldType.email,
            onChanged: (value) {},
          ),
        ),
      );
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(
        GEHCCustomTextField(
          controller: controller,
          labelText: 'Password',
          fieldType: FieldType.password,
          onChanged: (value) {},
        ),
      ));

      expect(find.byIcon(Icons.visibility), findsOneWidget);

      //Tap eye icon
      await tester.tap(find.byIcon(Icons.visibility),);
      //rebuilds the test widget
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);

      await tester.tap(find.byIcon(Icons.visibility_off),);
      await tester.pump();
      expect(find.byIcon(Icons.visibility), findsOneWidget);
    });

    testWidgets('validates email input', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(
        GEHCCustomTextField(
          controller: controller,
          labelText: 'Email',
          fieldType: FieldType.email,
          onChanged: (value) {},
          showError: true,
        ),
      ));
      await tester.enterText(find.byType(TextField), 'dharanya');
      await tester.pump();
      expect(find.text('Enter a valid email address'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'dharanya@gmail.com');
      await tester.pump();
      expect(find.text('Enter a valid email address'), findsNothing);
    });

    testWidgets('validates password input', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(
        GEHCCustomTextField(
          controller: controller,
          labelText: 'Password',
          fieldType: FieldType.password,
          onChanged: (value) {},
          showError: true,
        ),
      ));

      await tester.enterText(find.byType(TextField), 'dharu');
      await tester.pump();
      expect(find.text('Password must be at least 8 characters long'),
          findsOneWidget);

      await tester.enterText(find.byType(TextField), 'Dharanya');
      await tester.pump();
      expect(find.text('Password must contain at least one number'),
          findsOneWidget);
    });

    testWidgets('does not display message when show error is false', (WidgetTester tester) async {
      await tester.pumpWidget(testableWidget(
        GEHCCustomTextField(
          controller: controller,
          labelText: 'Password',
          fieldType: FieldType.password,
          onChanged: (value) {},
          showError: false,
        ),
      ));

      await tester.enterText(find.byType(TextField), 'dharu');
      await tester.pump();
      expect(find.text('Password must be at least 8 characters long'),
          findsNothing);
    });
  });
}
