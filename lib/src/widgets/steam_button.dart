import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'steam_container.dart';

/// A customizable button widget with a pressed state that adjusts its styling,
/// including the option to show or hide underlay text when disabled.
class SteamButton extends StatefulWidget {
  /// Creates a [SteamButton] with a child widget and an optional callback function
  /// that is triggered when the button is pressed.
  ///
  /// If [onPressed] is null, the button is considered disabled.
  /// Use [showUnderlayTextStyle] to control the visibility of the underlay text style.
  const SteamButton({
    super.key,
    required this.onPressed,
    required this.child,
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

  @override
  Widget build(BuildContext context) {
    final steamTheme = Theme.of(context).extension<SteamTheme>();
    final buttonTheme = Theme.of(context).extension<SteamButtonTheme>();

    // Use provided padding, or fall back to the theme's padding.
    final buttonPadding = widget.padding ?? buttonTheme!.padding;

    return MouseRegion(
      child: GestureDetector(
        onTapDown: (_) => widget._isDisabled ? null : setState(() => _pressed = true),
        onTapUp: (_) => widget._isDisabled ? null : setState(() => _pressed = false),
        onTapCancel: () => widget._isDisabled ? null : setState(() => _pressed = false),
        onTap: widget._isDisabled ? null : widget.onPressed,
        child: SteamContainer(
          padding: buttonPadding,
          alternateBorderColor: _pressed,
          backgroundColor: buttonTheme?.backgroundColor,
          child: Transform.translate(
            offset: _pressed ? const Offset(1, 1) : const Offset(0, 0),
            child: Stack(
              children: [
                if (widget._isDisabled && widget.showUnderlayTextStyle)
                  _UnderlayText(
                    steamTheme: steamTheme,
                    child: widget.child as Text,
                  ),
                DefaultTextStyle(
                  style: buttonTheme?.labelTextStyle ??
                      TextStyle(
                        color: widget._isDisabled ? steamTheme!.tertiary : steamTheme!.onPrimary,
                      ),
                  child: widget.child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that renders an "underlay" text effect, typically used when
/// the [SteamButton] is disabled to create a shadowed text effect.
class _UnderlayText extends StatelessWidget {
  /// Creates an underlay text effect based on the provided [steamTheme] and [child] widget.
  ///
  /// The [steamTheme] defines the color and styling of the underlay.
  const _UnderlayText({
    required this.steamTheme,
    required this.child,
  });

  /// The theme used to style the underlay effect.
  final SteamTheme? steamTheme;

  /// The child widget, typically a [Text] widget, to which the underlay effect is applied.
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
