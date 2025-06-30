import 'package:flutter/material.dart';
import 'package:steam_ui/src/theme.dart';
import 'package:steam_ui/src/widgets/steam_container.dart';

/// A customizable text field widget with label support and a focus state,
/// using a container style based on the Steam UI theme.
class SteamTextField extends StatefulWidget {
  /// Creates a [SteamTextField] widget with optional configurations for label,
  /// initial text, text input type, and more.
  ///
  /// [onChanged] triggers when the text changes.
  const SteamTextField({
    super.key,
    this.label,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
  });

  /// An optional label displayed above the text field.
  final Widget? label;

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Callback that is triggered whenever the text changes.
  final ValueChanged<String>? onChanged;

  /// Type of keyboard to use for editing the text (e.g., [TextInputType.text]).
  final TextInputType? keyboardType;

  /// Whether to obscure the text, useful for password fields.
  final bool obscureText;

  @override
  State<SteamTextField> createState() => _SteamTextFieldState();
}

class _SteamTextFieldState extends State<SteamTextField> {
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cTheme = Theme.of(context).extension<SteamTextFieldTheme>();

    final unFocusColor = cTheme!.labelTextStyle.color;
    final onFocusColor = cTheme.onFocusLabelColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display label if provided
        if (widget.label != null)
          DefaultTextStyle(
            style: cTheme.labelTextStyle.copyWith(
              color: _isFocused ? onFocusColor : unFocusColor,
            ),
            child: widget.label!,
          ),
        if (widget.label != null) const SizedBox(height: 5),
        SteamContainer(
          backgroundColor: cTheme.backgroundColor,
          alternateBorderColor: true,
          padding: const EdgeInsets.only(left: 3, bottom: 3),
          child: TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText,
            style: cTheme.inputTextStyle,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }
}
