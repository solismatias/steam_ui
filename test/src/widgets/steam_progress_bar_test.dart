import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamProgressBar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: const Scaffold(
          body: SteamProgressBar(value: 75),
        ),
      ),
    );

    expect(find.byType(SteamProgressBar), findsOneWidget);
  });
}
