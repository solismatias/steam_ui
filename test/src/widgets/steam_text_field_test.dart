import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  group('SteamTextField', () {
    testWidgets('renders with controller', (tester) async {
      final controller = TextEditingController(text: 'Initial Text');
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: Scaffold(
            body: SteamTextField(
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.text('Initial Text'), findsOneWidget);
    });

    testWidgets('updates text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: const Scaffold(
            body: SteamTextField(),
          ),
        ),
      );

      await tester.enterText(find.byType(SteamTextField), 'New Text');
      expect(find.text('New Text'), findsOneWidget);
    });
  });
}
