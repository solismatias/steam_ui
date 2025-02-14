import 'package:flutter/material.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

/// A custom scrollable widget that includes a Steam-themed scrollbar.
///
/// This widget wraps a [SingleChildScrollView] and attaches a scrollbar
/// for enhanced user experience. It supports both vertical and horizontal
/// scrolling and allows optional content clipping.
class SteamSingleChildScrollView extends StatefulWidget {
  /// Creates a [SteamSingleChildScrollView].
  ///
  /// Requires a [child] widget and optionally accepts a [ScrollController],
  /// a [scrollDirection] (defaults to vertical), and a [clipContent] flag.
  const SteamSingleChildScrollView({
    required this.child,
    this.scrollDirection = Axis.vertical,
    this.controller,
    this.clipContent = false,
    super.key,
  });

  /// The child widget that will be scrolled.
  final Widget child;

  /// The direction of scrolling (vertical or horizontal).
  final Axis scrollDirection;

  /// Determines whether content should be clipped.
  final bool clipContent;

  /// The scroll controller managing the scroll behavior.
  final ScrollController? controller;

  @override
  State<SteamSingleChildScrollView> createState() =>
      _SteamSingleChildScrollViewState();
}

class _SteamSingleChildScrollViewState
    extends State<SteamSingleChildScrollView> {
  late final ScrollController _scrollController =
      widget.controller ?? ScrollController();

  @override
  void dispose() {
    if (widget.controller == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const gap = SteamScrollbar.scrollbarSize;
        final children = [
          SizedBox(
            width: widget.scrollDirection == Axis.vertical
                ? constraints.maxWidth - gap
                : constraints.maxWidth,
            height: widget.scrollDirection == Axis.horizontal
                ? constraints.maxHeight - gap
                : constraints.maxHeight,
            child: SingleChildScrollView(
              scrollDirection: widget.scrollDirection,
              controller: _scrollController,
              child: SizeChangedLayoutNotifier(
                child: widget.child,
              ),
            ),
          ),
          SteamScrollbar(
            controller: _scrollController,
            direction: widget.scrollDirection,
          ),
        ];

        return NotificationListener<SizeChangedLayoutNotification>(
          onNotification: (notification) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {});
            });
            return true;
          },
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: widget.scrollDirection == Axis.vertical
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
          ),
        );
      },
    );
  }
}
