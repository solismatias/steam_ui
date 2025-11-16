import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/steam_pressable.dart';

/// A radio button widget with a Steam-like design.
class SteamRadio<T> extends StatefulWidget {
  /// Creates a [SteamRadio].
  const SteamRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  final T? groupValue;

  /// Called when the user selects this radio button.
  final ValueChanged<T?> onChanged;

  @override
  State<SteamRadio<T>> createState() => _SteamRadioState<T>();
}

class _SteamRadioState<T> extends State<SteamRadio<T>> {
  bool _pressed = false;

  void _handleTap({required bool isPressed}) {
    setState(() => _pressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final radioTheme = context.steamThemeExtension<SteamRadioTheme>();
    final isSelected = widget.value == widget.groupValue;

    return SteamPressable(
      onPressStart: () => _handleTap(isPressed: true),
      onPressEnd: () => _handleTap(isPressed: false),
      onPressed: () => widget.onChanged(widget.value),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _pressed ? radioTheme.dotColor : radioTheme.borderColor,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: radioTheme.dotColor,
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
