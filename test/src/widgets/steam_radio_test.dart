import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamRadio', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamRadio<int>(
            value: 1,
            groupValue: 1,
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.byType(SteamRadio<int>), findsOneWidget);
  });
}
