import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

class SteamSlider extends StatefulWidget {
  const SteamSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
  });

  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  @override
  State<SteamSlider> createState() => _SteamSliderState();
}

class _SteamSliderState extends State<SteamSlider> {
  late double _currentValue;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(SteamSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && !_isDragging) {
      _currentValue = widget.value;
    }
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  void _onDragUpdate(DragUpdateDetails details, double trackWidth) {
    final position = details.localPosition.dx;
    final selectedValue =
        (position / trackWidth * (widget.max - widget.min)) + widget.min;
    final clampedValue = selectedValue.clamp(widget.min, widget.max);
    widget.onChanged(clampedValue);
    setState(() {
      _currentValue = clampedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SteamTheme>();

    return SizedBox(
      height: 35,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          final thumbPosition = (trackWidth - 16) *
              (_currentValue - widget.min) /
              (widget.max - widget.min);

          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onHorizontalDragStart: _onDragStart,
              onHorizontalDragUpdate: (details) =>
                  _onDragUpdate(details, trackWidth),
              onHorizontalDragEnd: _onDragEnd,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SteamContainer(
                    height: 8,
                    width: trackWidth,
                    alternateBorderColor: true,
                    backgroundColor: theme?.tertiary,
                  ),
                  Positioned(
                    left: thumbPosition,
                    child: SteamContainer(
                      width: 16,
                      height: 24,
                      alternateBorderColor: _isDragging,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
