import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';

/// A generic container with customizable background, padding, and border color
/// that uses the `SteamContainerTheme` for its styling.
class SteamContainer extends StatelessWidget {
  /// A generic container with customizable background, padding, and border color
  /// that uses the `SteamContainerTheme` for its styling.
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
    final cTheme = Theme.of(context).extension<SteamContainerTheme>();

    // Use provided background color,
    // or fall back to the theme's background color.
    final containerBackgroundColor = backgroundColor ?? cTheme!.backgroundColor;

    // Use provided primary and secondary border colors,
    // or fall back to the theme's values.
    final primary = primaryBorderColor ?? cTheme!.primaryBorderColor;
    final secondary = secondaryBorderColor ?? cTheme!.secondaryBorderColor;

    // Use provided padding, or fall back to the theme's padding.
    final containerPadding = padding ?? cTheme!.padding;

    // Determine border colors based on alternateBorderColor flag.
    final top = alternateBorderColor ? secondary : primary;
    final left = alternateBorderColor ? secondary : primary;
    final right = alternateBorderColor ? primary : secondary;
    final bottom = alternateBorderColor ? primary : secondary;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        border: Border(
          top: BorderSide(color: top),
          left: BorderSide(color: left),
          right: BorderSide(color: right),
          bottom: BorderSide(color: bottom),
        ),
      ),
      child: Padding(
        padding: containerPadding,
        child: child,
      ),
    );
  }
}
