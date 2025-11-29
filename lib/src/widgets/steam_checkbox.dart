import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/steam_pressable.dart';

/// A checkbox widget that allows users to select a boolean value.
class SteamCheckbox extends StatefulWidget {
  /// Creates a [SteamCheckbox].
  ///
  /// The [value] determines whether the checkbox is checked.
  /// The [onChanged] callback is called when the user taps the checkbox.
  const SteamCheckbox({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Whether this checkbox is checked.
  final bool value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool> onChanged;

  @override
  State<SteamCheckbox> createState() => _SteamCheckboxState();
}

class _SteamCheckboxState extends State<SteamCheckbox> {
  bool _pressed = false;

  void _handleTap({required bool isPressed}) {
    setState(() => _pressed = isPressed);
  }

  @override
  Widget build(BuildContext context) {
    final checkboxTheme = context.steamThemeExtension<SteamCheckboxTheme>();
    return SteamPressable(
      onPressStart: () => _handleTap(isPressed: true),
      onPressEnd: () => _handleTap(isPressed: false),
      onPressed: () => widget.onChanged(!widget.value),
      child: Container(
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                _pressed ? checkboxTheme.checkColor : checkboxTheme.borderColor,
          ),
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                color: checkboxTheme.checkColor,
                size: 11,
              )
            : const SizedBox(),
      ),
    );
  }
}
