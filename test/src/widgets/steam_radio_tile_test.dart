import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamRadioTile', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamRadioTile<int>(
            value: 1,
            groupValue: 1,
            onChanged: (value) {},
            label: 'Test Label',
          ),
        ),
      ),
    );

    expect(find.byType(SteamRadioTile<int>), findsOneWidget);
    expect(find.text('Test Label'), findsOneWidget);
    expect(find.byType(SteamRadio<int>), findsOneWidget);
  });
}
