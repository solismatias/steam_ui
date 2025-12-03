import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamCheckboxTile', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamCheckboxTile(
            value: true,
            onChanged: (value) {},
            label: 'Test Label',
          ),
        ),
      ),
    );

    expect(find.byType(SteamCheckboxTile), findsOneWidget);
    expect(find.text('Test Label'), findsOneWidget);
    expect(find.byType(SteamCheckbox), findsOneWidget);
  });
}
