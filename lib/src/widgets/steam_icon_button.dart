import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

/// An icon button widget that responds to press gestures.
class SteamIconButton extends StatefulWidget {
  /// Creates a [SteamIconButton].
  ///
  /// The [icon] is the icon to display.
  /// The [onPressed] callback is triggered when the button is tapped.
  /// If [onPressed] is null, the button is disabled.
  const SteamIconButton({
    required this.icon,
    super.key,
    this.onPressed,
    this.onPressStart,
    this.onPressEnd,
    this.padding,
    this.size,
    this.color,
    this.disabled = false,
  });

  /// The icon displayed inside the button.
  final IconData icon;

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// Called when the press starts.
  final VoidCallback? onPressStart;

  /// Called when the press ends.
  final VoidCallback? onPressEnd;

  /// The padding around the icon.
  final EdgeInsets? padding;

  /// The color of the icon.
  final Color? color;

  /// The size of the icon.
  final double? size;

  /// Whether the button is disabled.
  final bool disabled;

  @override
  State<SteamIconButton> createState() => _SteamIconButtonState();
}

class _SteamIconButtonState extends State<SteamIconButton> {
  bool _pressed = false;

  /// Determines if the button should be disabled.
  bool get _isDisabled =>
      widget.disabled ||
      (widget.onPressed == null &&
          widget.onPressStart == null &&
          widget.onPressEnd == null);

  void _handlePress(VoidCallback? callback, {bool? isPressed}) {
    if (_isDisabled) return;
    callback?.call();
    setState(() {
      _pressed = isPressed ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final steamTheme = Theme.of(context).extension<SteamTheme>();
    final iconTheme = Theme.of(context).extension<SteamIconButtonTheme>();

    final padding = widget.padding ?? iconTheme!.padding;
    final color = widget.color ?? iconTheme?.iconColor;
    final size = widget.size ?? iconTheme?.iconSize;

    return SteamPressable(
      onPressed: widget.onPressed,
      onPressEnd: () => _handlePress(widget.onPressEnd),
      onPressStart: () => _handlePress(widget.onPressStart, isPressed: true),
      disabled: _isDisabled,
      child: SteamContainer(
        alternateBorderColor: !_isDisabled && _pressed,
        padding: padding,
        child: Icon(
          widget.icon,
          size: size,
          color: _isDisabled ? steamTheme!.shade : color,
        ),
      ),
    );
  }
}
