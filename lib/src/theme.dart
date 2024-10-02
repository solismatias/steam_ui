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

class SteamContainerTheme extends ThemeExtension<SteamContainerTheme> {
  /// {@macro steam_container_theme}
  const SteamContainerTheme({
    required this.backgroundColor,
    required this.primaryBorderColor,
    required this.secondaryBorderColor,
    this.labelTextStyle,
    this.padding = const EdgeInsets.all(10),
  });

  /// The background color of the container.
  final Color backgroundColor;

  /// The primary border color of the container.
  final Color primaryBorderColor;

  /// The secondary border color of the container.
  final Color secondaryBorderColor;

  /// The text style of the label, optional.
  final TextStyle? labelTextStyle;

  /// The padding inside the container, defaults to 10.
  final EdgeInsets padding;

  @override
  SteamContainerTheme copyWith({
    Color? backgroundColor,
    Color? primaryBorderColor,
    Color? secondaryBorderColor,
    TextStyle? labelTextStyle,
    EdgeInsets? padding,
  }) {
    return SteamContainerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryBorderColor: primaryBorderColor ?? this.primaryBorderColor,
      secondaryBorderColor: secondaryBorderColor ?? this.secondaryBorderColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      padding: padding ?? this.padding,
    );
  }

  @override
  SteamContainerTheme lerp(ThemeExtension<SteamContainerTheme>? other, double t) {
    if (other is! SteamContainerTheme) {
      return this;
    }
    return SteamContainerTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      primaryBorderColor: Color.lerp(primaryBorderColor, other.primaryBorderColor, t)!,
      secondaryBorderColor: Color.lerp(secondaryBorderColor, other.secondaryBorderColor, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
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
    tertiary: Color(0xFF343B2E), // Lighter green (tabs and highlights)
    highlight: Color(0xFF968830), // Yellow/gold (accent/highlight)
    onPrimary: Color(0xFFFFFFFF), // High emphasis (titles, most important text)
    onPrimaryVariant: Color(0xFFD2DDCC), // Medium emphasis (normal text)
    onPrimaryMuted: Color(0xFF757E6D), // Low emphasis (labels, less important values)
    shade: Color(0xFF757E6D), // Grey (shade, border or secondary elements)
  ),
}) {
  final containerTheme = SteamContainerTheme(
    backgroundColor: steamTheme.primary,
    primaryBorderColor: steamTheme.shade,
    secondaryBorderColor: steamTheme.tertiary,
  );

  return ThemeData(
    brightness: brightness,
    primaryColor: steamTheme.primary,
    highlightColor: steamTheme.highlight,
    extensions: [
      steamTheme,
      containerTheme,
    ],
  );
}
