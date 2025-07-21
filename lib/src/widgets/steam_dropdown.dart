import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/widgets.dart';

/// A single selectable entry in a Steam-styled dropdown menu.
///
/// Each entry consists of a [value] representing the selection
/// and a [label] displayed in the UI.
class SteamDropdownMenuEntry<T> {
  /// A single selectable entry in a Steam-styled dropdown menu.
  ///
  /// Each entry consists of a [value] representing the selection
  /// and a [label] displayed in the UI.
  const SteamDropdownMenuEntry({
    required this.value,
    required this.label,
  });

  /// The actual value of this entry.
  final T value;

  /// The text label displayed for this entry.
  final String label;
}

/// A Steam-styled dropdown menu widget that allows users
/// to select from a list of predefined options.
///
/// The menu is customizable, supports an [initialValue], and
/// invokes [onChanged] when the selected value changes.
class SteamDropdownMenu<T> extends StatefulWidget {
  /// A Steam-styled dropdown menu widget that allows users
  /// to select from a list of predefined options.
  ///
  /// The menu is customizable, supports an [initialValue], and
  /// invokes [onChanged] when the selected value changes.
  const SteamDropdownMenu({
    required this.entries,
    this.initialValue,
    this.onChanged,
    this.label,
    super.key,
  });

  /// A list of selectable entries for the dropdown.
  final List<SteamDropdownMenuEntry<T>> entries;

  /// The initial selected value when the dropdown is first displayed.
  final T? initialValue;

  /// A callback triggered when the selection changes.
  final void Function(T value)? onChanged;

  /// An optional label displayed above the text field.
  final Widget? label;

  @override
  State<SteamDropdownMenu<T>> createState() => _SteamDropdownMenuState<T>();
}

class _SteamDropdownMenuState<T> extends State<SteamDropdownMenu<T>> {
  late final _controller = OverlayPortalController();
  late T? _selectedValue = widget.initialValue;

  final _link = LayerLink();
  final GlobalKey _inputBoxKey = GlobalKey();
  double _inputBoxWidth = 200;

  // Track the "focused" state (when dropdown is open)
  bool _isOpen = false;

  /// Toggles the dropdown menu visibility.
  void _toggleMenu() {
    setState(() {
      if (_controller.isShowing) {
        _controller.hide();
        _isOpen = false;
      } else {
        // Determine the width of the button when opening the dropdown
        final renderBox =
            _inputBoxKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          setState(() {
            _inputBoxWidth = renderBox.size.width;
          });
        }
        _controller.show();
        _isOpen = true;
      }
    });
  }

  /// Handles user selection of an entry in the dropdown.
  void onEntrySelected({
    required SteamDropdownMenuEntry<T> entry,
    required bool isSelected,
  }) {
    if (isSelected) return;

    widget.onChanged?.call(entry.value);
    setState(() {
      _selectedValue = entry.value;
      _toggleMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dropdownTheme = Theme.of(context).extension<SteamTextFieldTheme>();

    // Find the currently selected entry
    final result =
        widget.entries.where((entry) => entry.value == _selectedValue);
    final selectedEntry = result.isNotEmpty ? result.first : null;

    final unFocusColor = dropdownTheme!.labelTextStyle.color;
    final onFocusColor = dropdownTheme.onFocusLabelColor;

    return Column(
      key: _inputBoxKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display label if provided
        if (widget.label != null)
          DefaultTextStyle(
            style: dropdownTheme.labelTextStyle.copyWith(
              color: _isOpen ? onFocusColor : unFocusColor,
            ),
            child: widget.label!,
          ),
        if (widget.label != null) const SizedBox(height: 5),

        CompositedTransformTarget(
          link: _link,
          child: OverlayPortal(
            controller: _controller,
            overlayChildBuilder: (context) {
              return CompositedTransformFollower(
                link: _link,
                targetAnchor: Alignment.bottomLeft,
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: _DialogContent(
                    width: _inputBoxWidth,
                    selectedValue: _selectedValue,
                    entries: widget.entries,
                    onEntrySelected: onEntrySelected,
                  ),
                ),
              );
            },
            child: _InputBox(
              selectedEntry: selectedEntry,
              onTap: _toggleMenu,
            ),
          ),
        ),
      ],
    );
  }
}

/// A dropdown menu dialog containing selectable entries.
class _DialogContent<T> extends StatefulWidget {
  const _DialogContent({
    required this.width,
    required this.selectedValue,
    required this.entries,
    required this.onEntrySelected,
    super.key,
  });

  /// The width of the dropdown dialog.
  final double width;

  /// The currently selected value in the dropdown.
  final dynamic selectedValue;

  /// The list of available entries to display.
  final List<SteamDropdownMenuEntry<T>> entries;

  /// A callback triggered when an entry is selected.
  final void Function({
    required SteamDropdownMenuEntry<T> entry,
    required bool isSelected,
  }) onEntrySelected;

  @override
  State<_DialogContent<T>> createState() => _DialogContentState<T>();
}

class _DialogContentState<T> extends State<_DialogContent<T>> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final dropdownTheme = Theme.of(context).extension<SteamDropdownTheme>()!;
    return SteamContainer(
      padding: EdgeInsets.zero,
      width: widget.width,
      height: 200,
      child: SteamSingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(widget.entries.length, (index) {
            final entry = widget.entries[index];
            final isSelected = entry.value == widget.selectedValue;
            final isHovered = _hoveredIndex == index;

            return MouseRegion(
              onEnter: (_) => setState(() => _hoveredIndex = index),
              onExit: (_) => setState(() => _hoveredIndex = null),
              child: Container(
                color: isSelected
                    ? dropdownTheme.onSelectedColor
                    : isHovered
                        ? dropdownTheme.onHoverColor
                        : null,
                padding: dropdownTheme.dialogPadding,
                child: SteamPressable(
                  onPressed: () => widget.onEntrySelected(
                    entry: entry,
                    isSelected: isSelected,
                  ),
                  child: Text(
                    entry.label,
                    style: dropdownTheme.entryTextStyle,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// A UI component representing the input box.
class _InputBox extends StatelessWidget {
  const _InputBox({
    required this.selectedEntry,
    required this.onTap,
  });

  /// The currently selected dropdown entry, if any.
  final SteamDropdownMenuEntry<dynamic>? selectedEntry;

  /// Callback triggered when the input box is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dropdownTheme = Theme.of(context).extension<SteamDropdownTheme>();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: SteamContainer(
          backgroundColor: dropdownTheme!.backgroundColor,
          alternateBorderColor: true,
          padding: dropdownTheme.inputPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: selectedEntry != null
                    ? Text(
                        selectedEntry?.label ?? '',
                        style: dropdownTheme.inputTextStyle,
                      )
                    : const SizedBox(),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down_rounded),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
