import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamSlider', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamSlider(
            value: 0.5,
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.byType(SteamSlider), findsOneWidget);
  });
}
