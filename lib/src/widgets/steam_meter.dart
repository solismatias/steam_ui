import 'package:flutter/material.dart';

/// A meter widget that visualizes a value from 0 to 100.
class SteamMeter extends StatelessWidget {
  /// Creates a [SteamMeter].
  ///
  /// The [value] must be between 0 and 100.
  const SteamMeter({
    required this.value,
    super.key,
  });

  /// value between 0 and 100
  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: List.generate(20, (index) {
          final threshold = (index + 1) * 5;
          final isActive = value >= threshold;
          return Flexible(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive
                    ? _getColor(index)
                    : Color.lerp(_getColor(index), Colors.black, 0.5),
              ),
            ),
          );
        }),
      ),
    );
  }

  Color _getColor(int index) {
    final percentage = index / 19;
    if (percentage < 0.5) {
      return Color.lerp(Colors.green, Colors.yellow, percentage * 2)!;
    } else {
      return Color.lerp(Colors.yellow, Colors.red, (percentage - 0.5) * 2)!;
    }
  }
}
