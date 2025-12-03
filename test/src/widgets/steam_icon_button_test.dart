import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamIconButton', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamIconButton(
            icon: Icons.add,
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.byType(SteamIconButton), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
