import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gehc_assignment/core/custom_components/custom_button.dart';

import 'common_testable_widget.dart';

void main() {
  group('GEHCCustomButton', () {
    testWidgets('displays text', (WidgetTester tester) async {
      const buttonText = 'Login';

      await tester.pumpWidget(
        testableWidget(
          GEHCCustomButton(
            text: buttonText,
            onPressed: () {},
            isEnabled: true,
          ),
        ),
      );

      final buttonFinder = find.text(buttonText);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('Button is disabled when isEnabled is false',
        (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        testableWidget(
          GEHCCustomButton(
            text: 'Login',
            onPressed: () {
              wasPressed = true;
            },
            isEnabled: false,
          ),
        ),
      );

      final buttonFinder = find.byType(ElevatedButton);
      await tester.tap(buttonFinder);
      await tester.pump();

      expect(buttonFinder, findsOneWidget);
      expect(wasPressed, isFalse);
    });
  });
}
