import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';

/// A [ListTile] with a [SteamCheckbox].
class SteamCheckboxTile extends StatelessWidget {
  /// Creates a [SteamCheckboxTile].
  const SteamCheckboxTile({
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
  });

  /// Whether this checkbox is checked.
  final bool value;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool> onChanged;

  /// The primary content of the list tile.
  final String label;

  @override
  Widget build(BuildContext context) {
    final steamTheme = context.steamThemeExtension<SteamTheme>();
    return SteamPressable(
      onPressed: () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SteamCheckbox(
            value: value,
            onChanged: onChanged,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(
              color: value ? steamTheme.highlight : steamTheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
