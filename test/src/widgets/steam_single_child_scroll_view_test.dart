import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamSingleChildScrollView', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: const Scaffold(
          body: SteamSingleChildScrollView(
            child: Text('Content'),
          ),
        ),
      ),
    );

    expect(find.byType(SteamSingleChildScrollView), findsOneWidget);
    expect(find.text('Content'), findsOneWidget);
  });
}
