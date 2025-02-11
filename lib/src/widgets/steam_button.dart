import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

/// A customizable button widget with a pressed state that adjusts its styling,
/// including the option to show or hide underlay text when disabled.
class SteamButton extends StatefulWidget {
  /// Creates a [SteamButton] with a child and an optional callback function
  /// that is triggered when the button is pressed.
  ///
  /// If [onPressed] is null, the button is considered disabled.
  /// [showUnderlayTextStyle] control the visibility of the underlay text style.
  const SteamButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.padding,
    this.showUnderlayTextStyle = true,
  }) : _isDisabled = onPressed == null;

  /// The callback that is triggered when the button is pressed.
  ///
  /// If this is null, the button will be disabled.
  final VoidCallback? onPressed;

  /// Whether the button is disabled.
  final bool _isDisabled;

  /// An optional padding to apply to the button, when null,
  /// defaults to the padding in `SteamButtonTheme`.
  final EdgeInsets? padding;

  /// The "label" of the button, which can be any widget (e.g., [Text]).
  final Widget child;

  /// Whether to show the underlay text style when the button is disabled.
  ///
  /// Defaults to `true`. If set to `false`, the underlay effect is not applied.
  final bool showUnderlayTextStyle;

  @override
  State<SteamButton> createState() => _SteamButtonState();
}

class _SteamButtonState extends State<SteamButton> {
  bool _pressed = false;

  void _handleTap({required bool isPressed}) {
    if (!widget._isDisabled) {
      setState(() => _pressed = isPressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final steamTheme = Theme.of(context).extension<SteamTheme>();
    final buttonTheme = Theme.of(context).extension<SteamButtonTheme>();

    // Use provided padding, or fall back to the theme's padding.
    final buttonPadding = widget.padding ?? buttonTheme!.padding;

    return SteamPressable(
      onPressed: () => widget.onPressed?.call(),
      onPressStart: () => _handleTap(isPressed: true),
      onPressEnd: () => _handleTap(isPressed: false),
      child: SteamContainer(
        padding: buttonPadding,
        alternateBorderColor: _pressed,
        backgroundColor: buttonTheme?.backgroundColor,
        child: Stack(
          children: [
            if (widget._isDisabled && widget.showUnderlayTextStyle)
              _UnderlayText(
                steamTheme: steamTheme,
                child: widget.child as Text,
              ),
            _DefaultTextStyle(
              buttonTheme: buttonTheme,
              steamTheme: steamTheme,
              isDisabled: widget._isDisabled,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultTextStyle extends StatelessWidget {
  const _DefaultTextStyle({
    required this.buttonTheme,
    required this.steamTheme,
    required this.isDisabled,
    required this.child,
  });

  final SteamButtonTheme? buttonTheme;
  final SteamTheme? steamTheme;
  final bool isDisabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: buttonTheme?.labelTextStyle ??
          TextStyle(
            color: isDisabled ? steamTheme!.tertiary : steamTheme!.onPrimary,
          ),
      child: child,
    );
  }
}

/// A widget that renders an "underlay" text effect, typically used when
/// the [SteamButton] is disabled to create a shadowed text effect.
class _UnderlayText extends StatelessWidget {
  /// Underlay text effect based on [steamTheme] and [child] widget.
  ///
  /// The [steamTheme] defines the color and styling of the underlay.
  const _UnderlayText({
    required this.steamTheme,
    required this.child,
  });

  /// The theme used to style the underlay effect.
  final SteamTheme? steamTheme;

  /// The child widget, to which the underlay effect is applied.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(1, 1),
      child: DefaultTextStyle(
        style: TextStyle(
          foreground: Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 1
            ..color = steamTheme!.shade,
        ),
        child: child,
      ),
    );
  }
}
