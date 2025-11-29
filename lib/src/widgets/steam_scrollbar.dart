import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/steam_container.dart';
import 'package:steam_ui/src/widgets/steam_icon_button.dart';

/// A scrollbar widget styled for the Steam UI.
class SteamScrollbar extends StatefulWidget {
  /// Creates a [SteamScrollbar].
  ///
  /// The [controller] manages the scroll behavior.
  /// The [direction] determines whether the scrollbar is vertical or horizontal
  const SteamScrollbar({
    required this.controller,
    required this.direction,
    super.key,
  });

  /// The controller that manages scrolling behavior.
  final ScrollController controller;

  /// The direction of the scrollbar (horizontal or vertical).
  final Axis direction;

  /// Base scroll speed in pixels per frame.
  static const double scrollSpeed = 50;

  /// Size of the scrollbar track and thumb.
  static const double scrollbarSize = 28;

  @override
  State<SteamScrollbar> createState() => _CustomScrollbarState();
}

class _CustomScrollbarState extends State<SteamScrollbar> {
  Timer? _timer;
  bool _isScrollingForward = false;
  double _currentScrollSpeed = 0;

  @override
  void initState() {
    super.initState();
    _currentScrollSpeed = SteamScrollbar.scrollSpeed;
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    _timer?.cancel();
    super.dispose();
  }

  /// Called when the scroll position changes, triggering a UI update.
  void _onScroll() {
    setState(() {});
  }

  /// Calculates the size of the scrollbar thumb based on the scrollable area.
  double _calculateThumbSize(double widgetSize) {
    final maxExtent = widget.controller.position.maxScrollExtent;

    return max(
      min(
        (widgetSize / (maxExtent + widgetSize)) * widgetSize,
        widgetSize * 0.8,
      ),
      SteamScrollbar.scrollbarSize / 2,
    );
  }

  /// Moves the scrollbar in the current scrolling direction.
  void _scroll() {
    if (_isScrollingForward &&
        widget.controller.offset < widget.controller.position.maxScrollExtent) {
      widget.controller.animateTo(
        (widget.controller.offset + _currentScrollSpeed).clamp(
          widget.controller.position.minScrollExtent,
          widget.controller.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    } else if (!_isScrollingForward && widget.controller.offset > 0) {
      widget.controller.animateTo(
        (widget.controller.offset - _currentScrollSpeed).clamp(
          widget.controller.position.minScrollExtent,
          widget.controller.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  /// Starts automatic scrolling in the specified direction.
  void _startScrolling(bool isScrollingForward) {
    _isScrollingForward = isScrollingForward;
    _currentScrollSpeed = SteamScrollbar.scrollSpeed;
    _scroll();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _scroll();
    });
  }

  /// Stops automatic scrolling.
  void _stopScrolling() {
    _currentScrollSpeed = SteamScrollbar.scrollSpeed;
    _timer?.cancel();
  }

  /// Handles manual scrolling by dragging the scrollbar thumb.
  void _panScroll(double offset, BoxConstraints constraints, double thumbSize) {
    final constraintSize = widget.direction == Axis.vertical
        ? constraints.maxHeight
        : constraints.maxWidth;

    final maxOffset = constraintSize - thumbSize - SteamScrollbar.scrollbarSize;
    final newOffset = widget.controller.offset +
        (offset / maxOffset) * widget.controller.position.maxScrollExtent;

    // Ensure the new offset is within valid bounds
    final clampedOffset = newOffset.clamp(
      widget.controller.position.minScrollExtent,
      widget.controller.position.maxScrollExtent,
    );

    widget.controller.jumpTo(clampedOffset);
  }

  /// Checks if the scrollbar is scrollable.
  bool _isScrollable() {
    return widget.controller.position.maxScrollExtent > 0;
  }

  @override
  Widget build(BuildContext context) {
    final steamTheme = Theme.of(context).extension<SteamTheme>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final constraintSize = widget.direction == Axis.vertical
            ? constraints.maxHeight
            : constraints.maxWidth;

        final thumbSize = _calculateThumbSize(constraintSize);
        final thumbPosition = SteamScrollbar.scrollbarSize +
            ((widget.controller.offset /
                    widget.controller.position.maxScrollExtent) *
                (constraintSize -
                    thumbSize -
                    SteamScrollbar.scrollbarSize * 2));

        return Container(
          color: steamTheme!.secondary,
          width: widget.direction == Axis.vertical
              ? SteamScrollbar.scrollbarSize
              : constraintSize,
          height: widget.direction == Axis.horizontal
              ? SteamScrollbar.scrollbarSize
              : constraintSize,
          child: Stack(
            children: [
              _ArrowButton(
                isForwardButton: false,
                isVertical: widget.direction == Axis.vertical,
                onPressStart: () => _startScrolling(false),
                onPressEnd: _stopScrolling,
                disabled: !_isScrollable(),
              ),
              if (_isScrollable())
                Positioned(
                  top: widget.direction == Axis.vertical ? thumbPosition : 0,
                  left: widget.direction == Axis.horizontal ? thumbPosition : 0,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final offset = widget.direction == Axis.vertical
                          ? details.delta.dy
                          : details.delta.dx;
                      _panScroll(
                        offset,
                        constraints,
                        thumbSize,
                      );
                    },
                    child: SteamContainer(
                      width: widget.direction == Axis.vertical
                          ? SteamScrollbar.scrollbarSize
                          : thumbSize,
                      height: widget.direction == Axis.horizontal
                          ? SteamScrollbar.scrollbarSize
                          : thumbSize,
                    ),
                  ),
                ),
              _ArrowButton(
                isVertical: widget.direction == Axis.vertical,
                onPressStart: () => _startScrolling(true),
                onPressEnd: _stopScrolling,
                disabled: !_isScrollable(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.onPressStart,
    required this.onPressEnd,
    required this.disabled,
    this.isForwardButton = true,
    this.isVertical = true,
  });

  final VoidCallback onPressStart;
  final VoidCallback onPressEnd;
  final bool disabled;
  final bool isForwardButton;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final icon = isVertical
        ? (isForwardButton
            ? Icons.arrow_drop_down_rounded
            : Icons.arrow_drop_up_rounded)
        : (isForwardButton
            ? Icons.arrow_right_rounded
            : Icons.arrow_left_rounded);

    final alignment = isVertical
        ? (isForwardButton ? Alignment.bottomCenter : Alignment.topCenter)
        : (isForwardButton ? Alignment.centerRight : Alignment.centerLeft);

    return Align(
      alignment: alignment,
      child: SizedBox(
        height: SteamScrollbar.scrollbarSize,
        child: SteamIconButton(
          icon: icon,
          onPressStart: onPressStart,
          onPressEnd: onPressEnd,
          disabled: disabled,
        ),
      ),
    );
  }
}
