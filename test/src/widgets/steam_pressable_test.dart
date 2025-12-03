import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamPressable', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamPressable(
            onPressed: () {},
            child: const Text('Press Me'),
          ),
        ),
      ),
    );

    expect(find.byType(SteamPressable), findsOneWidget);
    expect(find.text('Press Me'), findsOneWidget);
  });
}
