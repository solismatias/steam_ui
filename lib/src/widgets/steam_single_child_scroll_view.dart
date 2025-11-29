import 'package:flutter/material.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

/// A scrollable widget that includes a Steam-styled scrollbar.
class SteamSingleChildScrollView extends StatefulWidget {
  /// Creates a [SteamSingleChildScrollView].
  ///
  /// The [child] is the widget that will be scrolled.
  /// The [scrollDirection] determines the scrolling axis.
  /// The [controller] manages the scroll behavior.
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
