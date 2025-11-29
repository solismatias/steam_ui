import 'package:flutter/material.dart';

/// A widget that detects press gestures and provides visual feedback.
class SteamPressable extends StatefulWidget {
  /// Creates a [SteamPressable].
  ///
  /// The [child] is the widget to be displayed.
  /// [onPressed] is called when the widget is tapped.
  /// [enableOffsetEffect] toggles the visual press effect.
  const SteamPressable({
    required this.child,
    this.onPressed,
    this.onPressStart,
    this.onPressEnd,
    this.disabled = false,
    this.behavior,
    this.enableOffsetEffect = true,
    super.key,
  });

  /// The widget that will be displayed inside the pressable area.
  final Widget child;

  /// Called when the widget is tapped.
  final VoidCallback? onPressed;

  /// Called when the press starts.
  final VoidCallback? onPressStart;

  /// Called when the press ends or is canceled.
  final VoidCallback? onPressEnd;

  /// If `true`, disables interaction.
  final bool disabled;

  /// The gesture detector behavior.
  final HitTestBehavior? behavior;

  /// If `true`, the widget shifts slightly when pressed.
  final bool enableOffsetEffect;

  @override
  State<SteamPressable> createState() => _SteamPressableState();
}

class _SteamPressableState extends State<SteamPressable> {
  var _pressed = false;

  void _handlePress(VoidCallback? callback, {bool? isPressed}) {
    callback?.call();
    setState(() {
      _pressed = isPressed ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasListeners = !widget.disabled &&
        (widget.onPressed != null ||
            widget.onPressStart != null ||
            widget.onPressEnd != null);

    // Apply a slight offset when pressed, if the effect is enabled.
    final offset = (hasListeners && _pressed && widget.enableOffsetEffect)
        ? const Offset(1, 1)
        : Offset.zero;

    return MouseRegion(
      cursor:
          hasListeners ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Transform.translate(
        offset: offset,
        child: GestureDetector(
          behavior: widget.behavior,
          onTap: () => _handlePress(widget.onPressed),
          onTapDown: (_) => _handlePress(widget.onPressStart, isPressed: true),
          onTapUp: (_) => _handlePress(widget.onPressEnd),
          onTapCancel: () => _handlePress(widget.onPressEnd),
          child: widget.child,
        ),
      ),
    );
  }
}
