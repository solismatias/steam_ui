import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

const _thumbWidth = 16.0;
const _thumbHeight = 24.0;
const _trackHeight = 8.0;
const _tickMarkCount = 10;

/// A slider component with a Steam-like design.
class SteamSlider extends StatefulWidget {
  /// Creates a [SteamSlider].
  const SteamSlider({
    required this.value,
    required this.onChanged,
    super.key,
    this.min = 0.0,
    this.max = 1.0,
  }) : assert(min < max, 'min must be less than max');

  /// The currently selected value for this slider.
  ///
  /// The slider's thumb is drawn at a position that corresponds to this value.
  final double value;

  /// Called during a drag when the user is selecting a new value for the
  /// slider by dragging.
  final ValueChanged<double> onChanged;

  /// The minimum value the user can select.
  ///
  /// Defaults to 0.0. Must be less than [max].
  final double min;

  /// The maximum value the user can select.
  ///
  /// Defaults to 1.0. Must be greater than [min].
  final double max;

  @override
  State<SteamSlider> createState() => _SteamSliderState();
}

class _SteamSliderState extends State<SteamSlider> {
  bool _isDragging = false;

  double get _currentValue => widget.value.clamp(widget.min, widget.max);

  void _handleDragStart(DragStartDetails details) {
    setState(() => _isDragging = true);
  }

  void _handleDragEnd(DragEndDetails details) {
    setState(() => _isDragging = false);
  }

  void _handleInteraction(Offset localPosition, double trackWidth) {
    final selectedValue =
        (localPosition.dx / trackWidth * (widget.max - widget.min)) +
            widget.min;
    final clampedValue = selectedValue.clamp(widget.min, widget.max);
    widget.onChanged(clampedValue);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SteamTheme>();
    final onPrimaryMuted = theme!.onPrimaryMuted;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: _thumbHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final trackWidth = constraints.maxWidth;
              return GestureDetector(
                onHorizontalDragStart: _handleDragStart,
                onHorizontalDragUpdate: (details) =>
                    _handleInteraction(details.localPosition, trackWidth),
                onHorizontalDragEnd: _handleDragEnd,
                onTapDown: (details) =>
                    _handleInteraction(details.localPosition, trackWidth),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: _SliderTrack(
                    isDragging: _isDragging,
                    currentValue: _currentValue,
                    min: widget.min,
                    max: widget.max,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        _TickMarks(color: onPrimaryMuted),
        const SizedBox(height: 2),
        _Labels(
          minLabel: widget.min.toString(),
          maxLabel: widget.max.toString(),
          color: onPrimaryMuted,
        ),
      ],
    );
  }
}

class _SliderTrack extends StatelessWidget {
  const _SliderTrack({
    required this.isDragging,
    required this.currentValue,
    required this.min,
    required this.max,
  });

  final bool isDragging;
  final double currentValue;
  final double min;
  final double max;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SteamTheme>();
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final thumbPosition =
            (trackWidth - _thumbWidth) * (currentValue - min) / (max - min);

        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            SteamContainer(
              height: _trackHeight,
              width: trackWidth,
              alternateBorderColor: true,
              backgroundColor: theme?.tertiary,
            ),
            Positioned(
              left: thumbPosition,
              child: SteamContainer(
                width: _thumbWidth,
                height: _thumbHeight,
                alternateBorderColor: isDragging,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TickMarks extends StatelessWidget {
  const _TickMarks({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        _tickMarkCount,
        (index) => Expanded(
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: color),
                right: index == _tickMarkCount - 1
                    ? BorderSide(color: color)
                    : BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({
    required this.minLabel,
    required this.maxLabel,
    required this.color,
  });

  final String minLabel;
  final String maxLabel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(minLabel, style: TextStyle(color: color)),
        Text(maxLabel, style: TextStyle(color: color)),
      ],
    );
  }
}
