import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamCheckbox', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamCheckbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.byType(SteamCheckbox), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);
  });
}
