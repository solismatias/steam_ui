import 'package:example/src/theme.dart';
import 'package:flutter/material.dart';

/// {@template steam_container}
/// A generic container with customizable background, padding, and border color
/// that uses the `SteamContainerTheme` for its styling.
/// {@endtemplate}
class SteamContainer extends StatelessWidget {
  /// {@macro steam_container}
  const SteamContainer({
    super.key,
    this.label,
    this.child,
    this.width,
    this.height,
    this.backgroundColor,
    this.borderColor,
    this.padding,
  });

  /// An optional label for the container.
  final String? label;

  /// Child of the container.
  final Widget? child;

  /// Container width.
  final double? width;

  /// Container height.
  final double? height;

  /// Background color of this container, when null, defaults to the color
  /// in `SteamContainerTheme`.
  final Color? backgroundColor;

  /// Border color of this container, when null, defaults to the color
  /// in `SteamContainerTheme`.
  final Color? borderColor;

  /// An optional padding to apply to the container, when null,
  /// defaults to the padding in `SteamContainerTheme`.
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    // final steamContainerTheme = context.steamThemeExtension<SteamContainerTheme>();
    final steamContainerTheme = Theme.of(context).extension<SteamContainerTheme>();

    // Use provided background color, or fall back to the theme's background color.
    final containerBackgroundColor = backgroundColor ?? steamContainerTheme!.backgroundColor;

    // Use provided border color, or fall back to the theme's border color.
    final containerBorderColor = borderColor ?? steamContainerTheme!.borderColor;

    // Use provided padding, or fall back to the theme's padding.
    final containerPadding = padding ?? steamContainerTheme!.padding;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        border: Border(
          top: BorderSide(color: containerBorderColor, width: 1),
          left: BorderSide(color: containerBorderColor, width: 1),
          right: BorderSide(color: containerBorderColor, width: 1),
          bottom: BorderSide(color: containerBorderColor, width: 1),
        ),
      ),
      child: Padding(
        padding: containerPadding,
        child: child,
      ),
    );
  }
}
