import 'package:flutter/material.dart';

/// {@template steam_theme}
/// Class with general theme information for Flutter Steam.
/// {@endtemplate}
class SteamTheme extends ThemeExtension<SteamTheme> {
  /// {@macro steam_theme}
  const SteamTheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.highlight,
    required this.onPrimary,
    required this.onPrimaryVariant,
    required this.onPrimaryMuted,
    required this.shade,
  });

  final Color primary;
  final Color secondary;
  final Color tertiary;
  final Color highlight;
  final Color onPrimary;
  final Color onPrimaryVariant;
  final Color onPrimaryMuted;
  final Color shade;

  @override
  SteamTheme copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? highlight,
    Color? onPrimary,
    Color? onPrimaryVariant,
    Color? onPrimaryMuted,
    Color? shade,
  }) {
    return SteamTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      highlight: highlight ?? this.highlight,
      onPrimary: onPrimary ?? this.onPrimary,
      onPrimaryVariant: onPrimaryVariant ?? this.onPrimaryVariant,
      onPrimaryMuted: onPrimaryMuted ?? this.onPrimaryMuted,
      shade: shade ?? this.shade,
    );
  }

  @override
  SteamTheme lerp(SteamTheme? other, double t) {
    if (other == null) return this;

    return SteamTheme(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      tertiary: Color.lerp(tertiary, other.tertiary, t) ?? tertiary,
      highlight: Color.lerp(highlight, other.highlight, t) ?? highlight,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      onPrimaryVariant: Color.lerp(onPrimaryVariant, other.onPrimaryVariant, t) ?? onPrimaryVariant,
      onPrimaryMuted: Color.lerp(onPrimaryMuted, other.onPrimaryMuted, t) ?? onPrimaryMuted,
      shade: Color.lerp(shade, other.shade, t) ?? shade,
    );
  }
}

/// Helper methods on [BuildContext] for the Flutter Steam.
extension SteamBuildContext on BuildContext {
  /// Returns the extension of type [T] from the context.
  ///
  /// Throws Exception if none is found.
  T steamThemeExtension<T>() {
    final theme = Theme.of(this);

    final ext = theme.extension<T>();

    if (ext == null) {
      throw Exception(
        'Cannot find extension $T on theme. Make sure to create a Flutter Steam '
        'theme using flutterSteamTheme method.',
      );
    }

    return ext;
  }
}

/// Creates a Flutter Steam [ThemeData].
ThemeData flutterSteamTheme({
  Brightness brightness = Brightness.dark,
  SteamTheme steamTheme = const SteamTheme(
    primary: Color(0xFF4C5844), // Dark green (background)
    secondary: Color(0xFF5A6A50), // Lighter green (tabs and highlights)
    tertiary: Color(0xFF3E4637), // Lighter green (tabs and highlights)
    highlight: Color(0xFF968830), // Yellow/gold (accent/highlight)
    onPrimary: Color(0xFFFFFFFF), // High emphasis (titles, most important text)
    onPrimaryVariant: Color(0xFFD2DDCC), // Medium emphasis (normal text)
    onPrimaryMuted: Color(0xFFA3AF9B), // Low emphasis (labels, less important values)
    shade: Color(0xFFA3AF9B), // Grey (shade, border or secondary elements)
  ),
}) {
  return ThemeData(
    brightness: brightness,
    primaryColor: steamTheme.primary,
    highlightColor: steamTheme.highlight,
    extensions: [
      steamTheme,
    ],
  );
}
