import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';

/// A list tile that contains a [SteamRadio] and a label.
class SteamRadioTile<T> extends StatelessWidget {
  /// Creates a [SteamRadioTile].
  ///
  /// The [value] is the value represented by this radio button.
  /// The [groupValue] is the currently selected value for the group.
  /// The [onChanged] callback is called when the user selects this radio button
  /// The [label] is displayed next to the radio button.
  const SteamRadioTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    super.key,
  });

  /// The value represented by this radio button.
  final T value;

  /// The currently selected value for a group of radio buttons.
  final T? groupValue;

  /// Called when the user selects this radio button.
  final ValueChanged<T?> onChanged;

  /// The primary content of the list tile.
  final String label;

  @override
  Widget build(BuildContext context) {
    final steamTheme = context.steamThemeExtension<SteamTheme>();
    final isSelected = value == groupValue;

    return SteamPressable(
      onPressed: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SteamRadio(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? steamTheme.highlight : steamTheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
