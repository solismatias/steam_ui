import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('SteamMeter render', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: const Scaffold(
          body: SteamMeter(value: 50),
        ),
      ),
    );

    expect(find.byType(SteamMeter), findsOneWidget);
  });
}
