import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  group('SteamTheme', () {
    test('supports value equality', () {
      expect(
        const SteamTheme(
          primary: Colors.black,
          secondary: Colors.white,
          tertiary: Colors.red,
          highlight: Colors.blue,
          highlightMuted: Colors.green,
          onPrimary: Colors.yellow,
          onPrimaryVariant: Colors.purple,
          onPrimaryMuted: Colors.orange,
          shade: Colors.grey,
        ),
        equals(
          const SteamTheme(
            primary: Colors.black,
            secondary: Colors.white,
            tertiary: Colors.red,
            highlight: Colors.blue,
            highlightMuted: Colors.green,
            onPrimary: Colors.yellow,
            onPrimaryVariant: Colors.purple,
            onPrimaryMuted: Colors.orange,
            shade: Colors.grey,
          ),
        ),
      );
    });

    test('copyWith creates a new instance with overridden values', () {
      const theme = SteamTheme(
        primary: Colors.black,
        secondary: Colors.white,
        tertiary: Colors.red,
        highlight: Colors.blue,
        highlightMuted: Colors.green,
        onPrimary: Colors.yellow,
        onPrimaryVariant: Colors.purple,
        onPrimaryMuted: Colors.orange,
        shade: Colors.grey,
      );

      final newTheme = theme.copyWith(primary: Colors.pink);

      expect(newTheme.primary, equals(Colors.pink));
      expect(newTheme.secondary, equals(Colors.white));
    });

    test('lerp interpolates between two themes', () {
      const theme1 = SteamTheme(
        primary: Colors.black,
        secondary: Colors.white,
        tertiary: Colors.red,
        highlight: Colors.blue,
        highlightMuted: Colors.green,
        onPrimary: Colors.yellow,
        onPrimaryVariant: Colors.purple,
        onPrimaryMuted: Colors.orange,
        shade: Colors.grey,
      );

      const theme2 = SteamTheme(
        primary: Colors.white,
        secondary: Colors.black,
        tertiary: Colors.blue,
        highlight: Colors.red,
        highlightMuted: Colors.yellow,
        onPrimary: Colors.green,
        onPrimaryVariant: Colors.orange,
        onPrimaryMuted: Colors.purple,
        shade: Colors.pink,
      );

      final lerpedTheme = theme1.lerp(theme2, 0.5);

      expect(
        lerpedTheme.primary,
        equals(Color.lerp(Colors.black, Colors.white, 0.5)),
      );
      expect(
        lerpedTheme.secondary,
        equals(Color.lerp(Colors.white, Colors.black, 0.5)),
      );
    });

    test('flutterSteamTheme returns a valid ThemeData', () {
      final themeData = flutterSteamTheme();
      expect(themeData, isA<ThemeData>());
      expect(themeData.extension<SteamTheme>(), isNotNull);
      expect(themeData.extension<SteamButtonTheme>(), isNotNull);
    });
  });
}
