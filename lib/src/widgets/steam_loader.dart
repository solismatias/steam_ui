import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';

/// A visual loader widget that represents a value from 0 to 100 using
/// a horizontal bar with highlighted blocks.
class SteamLoader extends StatelessWidget {
  /// Creates an instance of [SteamLoader] with the given [value].
  ///
  /// The [value] determines the number of active blocks in the loader.
  const SteamLoader({
    required this.value,
    super.key,
  });

  /// Value between 0 and 100 that represents the loading progress
  final double value;


  /// Returns the normalized value between 0 and 100
  double get normalizedValue => value.clamp(0.0, 100.0);

  @override
  Widget build(BuildContext context) {
    final steamTheme = Theme.of(context).extension<SteamTheme>();
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        // Calculate how many blocks we can fit (block width: 16, gap: 8)
        // -1 to ensure no overflow
        final blockCount = (availableWidth / 24).floor(); 
        // Calculate how many blocks should be active
        final activeBlocks = ((normalizedValue / 100) * blockCount).floor();
        
        return SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(activeBlocks, (index) {
              return Container(
                width: 16,
                decoration: BoxDecoration(
                  color: steamTheme!.highlight,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
