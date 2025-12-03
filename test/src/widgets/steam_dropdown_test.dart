import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamDropdown', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: SteamDropdown<String>(
            entries: const [
              SteamDropdownMenuEntry(value: 'a', label: 'Option A'),
              SteamDropdownMenuEntry(value: 'b', label: 'Option B'),
            ],
            initialValue: 'a',
            onChanged: (value) {},
          ),
        ),
      ),
    );

    expect(find.byType(SteamDropdown<String>), findsOneWidget);
    expect(find.text('Option A'), findsOneWidget);
  });
}
