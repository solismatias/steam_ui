import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  group('SteamContainer', () {
    testWidgets('renders child', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: const Scaffold(
            body: SteamContainer(
              child: Text('Container Content'),
            ),
          ),
        ),
      );

      expect(find.text('Container Content'), findsOneWidget);
    });

    testWidgets('applies default padding from theme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: flutterSteamTheme(),
          home: const Scaffold(
            body: SteamContainer(
              child: Text('Content'),
            ),
          ),
        ),
      );

      expect(
        find.descendant(
          of: find.byType(SteamContainer),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Padding && widget.padding == const EdgeInsets.all(10),
          ),
        ),
        findsOneWidget,
      );
    });
  });
}
