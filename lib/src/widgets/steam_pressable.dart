import 'package:flutter/material.dart';

/// {@template steam_pressable}
/// A pressable widget that provides a subtle visual feedback
///
/// This widget supports callbacks for different press states:
/// - `onPressed`: Triggered when the widget is tapped.
/// - `onPressStart`: Triggered when a tap begins.
/// - `onPressEnd`: Triggered when a tap ends or is canceled.
///
/// The `enableOffsetEffect` flag allows disabling the movement effect.
///
/// Example:
/// ```dart
/// SteamPressable(
///   onPressed: () => print('Pressed!'),
///   child: Container(
///     padding: EdgeInsets.all(8),
///     color: Colors.blue,
///     child: Text('Press Me'),
///   ),
/// )
/// ```
/// {@endtemplate}
class SteamPressable extends StatefulWidget {
  /// {@macro steam_pressable}
  const SteamPressable({
    required this.child,
    this.onPressed,
    this.onPressStart,
    this.onPressEnd,
    this.disabled,
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
  final bool? disabled;

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
    final hasListeners = widget.onPressed != null ||
        widget.onPressStart != null ||
        widget.onPressEnd != null;

    // Apply a slight offset when pressed, if the effect is enabled.
    final offset = (hasListeners && _pressed && widget.enableOffsetEffect)
        ? const Offset(1, 1)
        : Offset.zero;

    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        behavior: widget.behavior,
        onTap: () => _handlePress(widget.onPressed),
        onTapDown: (_) => _handlePress(widget.onPressStart, isPressed: true),
        onTapUp: (_) => _handlePress(widget.onPressEnd),
        onTapCancel: () => _handlePress(widget.onPressEnd),
        child: widget.child,
      ),
    );
  }
}
