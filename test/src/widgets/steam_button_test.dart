import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  group('SteamButton', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: Scaffold(
            body: SteamButton(
              onPressed: () {},
              child: const Text('Click Me'),
            ),
          ),
        ),
      );

      expect(find.text('Click Me'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: Scaffold(
            body: SteamButton(
              onPressed: () => pressed = true,
              child: const Text('Click Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SteamButton));
      expect(pressed, isTrue);
    });

    testWidgets('does not call onPressed when disabled', (tester) async {
      const pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: const Scaffold(
            body: SteamButton(
              onPressed: null,
              child: Text('Click Me'),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(SteamButton));
      expect(pressed, isFalse);
    });
  });
}
