import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  testWidgets('render SteamScrollbar', (tester) async {
    final controller = ScrollController();
    await tester.pumpWidget(
      MaterialApp(
        theme: flutterSteamTheme(),
        home: Scaffold(
          body: Stack(
            children: [
              ListView.builder(
                controller: controller,
                itemCount: 100,
                itemBuilder: (context, index) => Text('Item $index'),
              ),
              SteamScrollbar(
                controller: controller,
                direction: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(SteamScrollbar), findsOneWidget);
  });
}
