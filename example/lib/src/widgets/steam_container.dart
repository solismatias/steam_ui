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
    this.primaryBorderColor,
    this.secondaryBorderColor,
    this.padding,
    this.alternateBorderColor = false,
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

  /// Primary border color of this container, when null, defaults to the color
  /// in `SteamContainerTheme`.
  final Color? primaryBorderColor;

  /// Secondary border color of this container, when null, defaults to the color
  /// in `SteamContainerTheme`.
  final Color? secondaryBorderColor;

  /// An optional padding to apply to the container, when null,
  /// defaults to the padding in `SteamContainerTheme`.
  final EdgeInsets? padding;

  /// If true, alternate the border colors (secondary on top/left and primary on bottom/right).
  final bool alternateBorderColor;

  @override
  Widget build(BuildContext context) {
    final steamContainerTheme = Theme.of(context).extension<SteamContainerTheme>();

    // Use provided background color, or fall back to the theme's background color.
    final containerBackgroundColor = backgroundColor ?? steamContainerTheme!.backgroundColor;

    // Use provided primary and secondary border colors, or fall back to the theme's values.
    final containerPrimaryBorderColor = primaryBorderColor ?? steamContainerTheme!.primaryBorderColor;
    final containerSecondaryBorderColor = secondaryBorderColor ?? steamContainerTheme!.secondaryBorderColor;

    // Use provided padding, or fall back to the theme's padding.
    final containerPadding = padding ?? steamContainerTheme!.padding;

    // Determine border colors based on alternateBorderColor flag.
    final topBorderColor = alternateBorderColor ? containerSecondaryBorderColor : containerPrimaryBorderColor;
    final leftBorderColor = alternateBorderColor ? containerSecondaryBorderColor : containerPrimaryBorderColor;
    final rightBorderColor = alternateBorderColor ? containerPrimaryBorderColor : containerSecondaryBorderColor;
    final bottomBorderColor = alternateBorderColor ? containerPrimaryBorderColor : containerSecondaryBorderColor;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        border: Border(
          top: BorderSide(color: topBorderColor, width: 1),
          left: BorderSide(color: leftBorderColor, width: 1),
          right: BorderSide(color: rightBorderColor, width: 1),
          bottom: BorderSide(color: bottomBorderColor, width: 1),
        ),
      ),
      child: Padding(
        padding: containerPadding,
        child: child,
      ),
    );
  }
}
