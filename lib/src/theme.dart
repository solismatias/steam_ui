import 'package:flutter/material.dart';

import 'package:steam_ui/steam_ui.dart';

/// {@template steam_theme}
/// Class with general theme information for Flutter Steam.
/// {@endtemplate}
class SteamTheme extends ThemeExtension<SteamTheme> {
  /// {@macro steam_theme}
  const SteamTheme({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.highlight,
    required this.highlightMuted,
    required this.onPrimary,
    required this.onPrimaryVariant,
    required this.onPrimaryMuted,
    required this.shade,
  });

  /// The primary color of the theme,
  /// used for the most prominent elements.
  final Color primary;

  /// The secondary color of the theme,
  /// used for accents and less prominent elements.
  final Color secondary;

  /// The tertiary color of the theme,
  /// used for additional accents and less prominent elements.
  final Color tertiary;

  /// The highlight color, used to draw attention to important elements.
  final Color highlight;

  /// The muted highlight color, used to draw attention to important elements.
  final Color highlightMuted;

  /// The color applied on top of the primary color,
  /// typically for text or icons.
  final Color onPrimary;

  /// A variant of [onPrimary], used in slightly different
  /// contexts like hover or focus states.
  final Color onPrimaryVariant;

  /// A muted version of [onPrimary], used for less prominent text or icons.
  final Color onPrimaryMuted;

  /// A shade of the primary color,
  /// typically used for shadows or background accents.
  final Color shade;

  @override
  SteamTheme copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? highlight,
    Color? highlightMuted,
    Color? onPrimary,
    Color? onPrimaryVariant,
    Color? onPrimaryMuted,
    Color? shade,
  }) {
    return SteamTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      highlight: highlight ?? this.highlight,
      highlightMuted: highlightMuted ?? this.highlightMuted,
      onPrimary: onPrimary ?? this.onPrimary,
      onPrimaryVariant: onPrimaryVariant ?? this.onPrimaryVariant,
      onPrimaryMuted: onPrimaryMuted ?? this.onPrimaryMuted,
      shade: shade ?? this.shade,
    );
  }

  @override
  SteamTheme lerp(SteamTheme? other, double t) {
    if (other == null) return this;

    return SteamTheme(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      tertiary: Color.lerp(tertiary, other.tertiary, t) ?? tertiary,
      highlight: Color.lerp(highlight, other.highlight, t) ?? highlight,
      highlightMuted:
          Color.lerp(highlightMuted, other.highlightMuted, t) ?? highlightMuted,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      onPrimaryVariant: Color.lerp(
            onPrimaryVariant,
            other.onPrimaryVariant,
            t,
          ) ??
          onPrimaryVariant,
      onPrimaryMuted: Color.lerp(
            onPrimaryMuted,
            other.onPrimaryMuted,
            t,
          ) ??
          onPrimaryMuted,
      shade: Color.lerp(shade, other.shade, t) ?? shade,
    );
  }
}

/// {@template steam_container_theme}
/// A customizable theme for containers in the Steam UI package.
///
/// A [SteamContainerTheme] provides styling for the [SteamContainer] widget,
/// including background color, border colors, label text style, and padding.
///
/// By default, the [SteamContainerTheme] allows the following properties:
///
///  - [backgroundColor] defines the background color of the container.
///  - [primaryBorderColor] defines the primary border color used on the top/left sides of the container.
///  - [secondaryBorderColor] defines the secondary border color used on the bottom/right sides of the container.
///  - [labelTextStyle] defines an optional text style for labels
/// within the container.
///  - [padding] defines the inner padding for the container,
/// with a default value of 10.
///
/// You can customize the theme by using the `copyWith`
/// method to override any of these properties,
/// or by applying a new instance of `SteamContainerTheme`
/// through the `ThemeData.extension`.
///
/// {@endtemplate}
class SteamContainerTheme extends ThemeExtension<SteamContainerTheme> {
  /// {@macro steam_container_theme}
  const SteamContainerTheme({
    required this.backgroundColor,
    required this.primaryBorderColor,
    required this.secondaryBorderColor,
    this.labelTextStyle,
    this.padding = const EdgeInsets.all(10),
  });

  /// The background color of the container.
  final Color backgroundColor;

  /// The primary border color of the container.
  final Color primaryBorderColor;

  /// The secondary border color of the container.
  final Color secondaryBorderColor;

  /// The text style of the label, optional.
  final TextStyle? labelTextStyle;

  /// The padding inside the container, defaults to 10.
  final EdgeInsets padding;

  @override
  SteamContainerTheme copyWith({
    Color? backgroundColor,
    Color? primaryBorderColor,
    Color? secondaryBorderColor,
    TextStyle? labelTextStyle,
    EdgeInsets? padding,
  }) {
    return SteamContainerTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryBorderColor: primaryBorderColor ?? this.primaryBorderColor,
      secondaryBorderColor: secondaryBorderColor ?? this.secondaryBorderColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      padding: padding ?? this.padding,
    );
  }

  @override
  SteamContainerTheme lerp(
    ThemeExtension<SteamContainerTheme>? other,
    double t,
  ) {
    if (other is! SteamContainerTheme) {
      return this;
    }
    return SteamContainerTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      primaryBorderColor: Color.lerp(
        primaryBorderColor,
        other.primaryBorderColor,
        t,
      )!,
      secondaryBorderColor: Color.lerp(
        secondaryBorderColor,
        other.secondaryBorderColor,
        t,
      )!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
    );
  }
}

/// {@template steam_button_theme}
/// A customizable theme for buttons in the Steam UI package.
///
/// A [SteamButtonTheme] provides styling for the [SteamButton] widget,
/// including background color, border colors, label text style, and padding.
///
/// By default, the [SteamButtonTheme] allows the following properties:
///
///  - [backgroundColor] defines the background color of the button.
///  - [labelTextStyle] defines an optional text style for labels
/// within the button.
///  - [padding] defines the inner padding for the button,
/// with a default value of horizontal 8 and vertical 4.
///
/// You can customize the theme by using the `copyWith`
/// method to override any of these properties,
/// or by applying a new instance of `SteamButtonTheme`
/// through the `ThemeData.extension`.
///
/// {@endtemplate}
class SteamButtonTheme extends ThemeExtension<SteamButtonTheme> {
  /// {@macro steam_button_theme}
  const SteamButtonTheme({
    required this.backgroundColor,
    this.labelTextStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  });

  /// The background color of the button.
  final Color backgroundColor;

  /// The text style of the label, optional.
  final TextStyle? labelTextStyle;

  /// The padding inside the button, defaults to horizontal 8 and vertical 4.
  final EdgeInsets padding;

  @override
  SteamButtonTheme copyWith({
    Color? backgroundColor,
    TextStyle? labelTextStyle,
    EdgeInsets? padding,
  }) {
    return SteamButtonTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      padding: padding ?? this.padding,
    );
  }

  @override
  SteamButtonTheme lerp(
    ThemeExtension<SteamButtonTheme>? other,
    double t,
  ) {
    if (other is! SteamButtonTheme) {
      return this;
    }
    return SteamButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t),
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
    );
  }
}

/// {@template steam_icon_button_theme}
/// A customizable theme for icon buttons in the Steam UI package.
///
/// A [SteamIconButtonTheme] provides styling for the [SteamIconButton] widget,
/// including background color, icon color, icon size, and padding.
///
/// By default, the [SteamIconButtonTheme] allows the following properties:
///
///  - [backgroundColor] defines the background color of the button.
///  - [iconColor] defines the color of the icon.
///  - [iconSize] defines the size of the icon, with a default value of 23.5.
///  - [padding] defines the inner padding for the button, defaulting to 2.
///
/// You can customize the theme by using the `copyWith`
/// method to override any of these properties,
/// or by applying a new instance of `SteamIconButtonTheme`
/// through the `ThemeData.extension`.
///
/// {@endtemplate}
class SteamIconButtonTheme extends ThemeExtension<SteamIconButtonTheme> {
  /// {@macro steam_icon_button_theme}
  const SteamIconButtonTheme({
    required this.backgroundColor,
    required this.iconColor,
    this.iconSize = 23.5,
    this.padding = const EdgeInsets.all(2),
  });

  /// The background color of the button.
  final Color backgroundColor;

  /// The color of the icon.
  final Color iconColor;

  /// The size of the icon, defaults to 23.5.
  final double iconSize;

  /// The padding inside the button, defaults to 2.
  final EdgeInsets padding;

  @override
  SteamIconButtonTheme copyWith({
    Color? backgroundColor,
    Color? iconColor,
    double? iconSize,
    EdgeInsets? padding,
  }) {
    return SteamIconButtonTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      padding: padding ?? this.padding,
    );
  }

  @override
  SteamIconButtonTheme lerp(
    ThemeExtension<SteamIconButtonTheme>? other,
    double t,
  ) {
    if (other is! SteamIconButtonTheme) {
      return this;
    }
    return SteamIconButtonTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      iconSize: Tween<double>(
        begin: iconSize,
        end: other.iconSize,
      ).transform(t),
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
    );
  }
}

/// {@template steam_textfield_theme}
/// A customizable theme for text fields in the Steam UI package.
///
/// A [SteamTextFieldTheme] provides styling for the [SteamTextField] widget,
/// including background color, label text style, input text style,
/// on-focus label color and padding.
///
/// By default, the [SteamTextFieldTheme] allows the following properties:
///
///  - [backgroundColor] defines the background color of the text field.
///  - [labelTextStyle] defines the text style for the label.
///  - [inputTextStyle] defines the text style for the input value.
///  - [onFocusLabelColor] label color when the text field is focused.
///  - [padding] padding inside the text field, with a default value.
///
/// Customize theme using `copyWith` method to override any property,
/// or by applying a new instance of `SteamTextFieldTheme`
/// through the `ThemeData.extension`.
/// {@endtemplate}
class SteamTextFieldTheme extends ThemeExtension<SteamTextFieldTheme> {
  /// {@macro steam_textfield_theme}
  const SteamTextFieldTheme({
    required this.backgroundColor,
    required this.labelTextStyle,
    required this.onFocusLabelColor,
    this.inputTextStyle,
    this.padding = const EdgeInsets.only(left: 3, bottom: 3),
    this.disabledBackgroundColor,
    this.disabledTextStyle,
  });

  /// The background color of the text field.
  final Color backgroundColor;

  /// The text style of the label.
  final TextStyle labelTextStyle;

  /// The text style of the input value.
  final TextStyle? inputTextStyle;

  /// The color of the label when the text field is focused.
  final Color onFocusLabelColor;

  /// The padding inside the text field, defaults to left: 3, top: 0, bottom: 3.
  final EdgeInsets padding;

  /// The background color of the text field when it is disabled.
  final Color? disabledBackgroundColor;

  /// The text style of the text field when it is disabled.
  final TextStyle? disabledTextStyle;

  @override
  SteamTextFieldTheme copyWith({
    Color? backgroundColor,
    TextStyle? labelTextStyle,
    TextStyle? inputTextStyle,
    Color? onFocusLabelColor,
    EdgeInsets? padding,
    Color? disabledBackgroundColor,
    TextStyle? disabledTextStyle,
  }) {
    return SteamTextFieldTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      onFocusLabelColor: onFocusLabelColor ?? this.onFocusLabelColor,
      padding: padding ?? this.padding,
      disabledBackgroundColor:
          disabledBackgroundColor ?? this.disabledBackgroundColor,
      disabledTextStyle: disabledTextStyle ?? this.disabledTextStyle,
    );
  }

  @override
  SteamTextFieldTheme lerp(
    ThemeExtension<SteamTextFieldTheme>? other,
    double t,
  ) {
    if (other is! SteamTextFieldTheme) {
      return this;
    }
    return SteamTextFieldTheme(
      backgroundColor: Color.lerp(
        backgroundColor,
        other.backgroundColor,
        t,
      )!,
      labelTextStyle: TextStyle.lerp(
        labelTextStyle,
        other.labelTextStyle,
        t,
      )!,
      inputTextStyle: TextStyle.lerp(
        inputTextStyle,
        other.inputTextStyle,
        t,
      ),
      onFocusLabelColor: Color.lerp(
        onFocusLabelColor,
        other.onFocusLabelColor,
        t,
      )!,
      padding: EdgeInsets.lerp(padding, other.padding, t) ?? padding,
      disabledBackgroundColor: Color.lerp(
        disabledBackgroundColor,
        other.disabledBackgroundColor,
        t,
      ),
      disabledTextStyle: TextStyle.lerp(
        disabledTextStyle,
        other.disabledTextStyle,
        t,
      ),
    );
  }
}

/// {@template steam_dropdown_theme}
/// A customizable theme for dropdown menus in the Steam UI package.
///
/// Defines the appearance of a dropdown menu, including:
/// - [backgroundColor]: Background color of the dropdown menu.
/// - [onSelectedColor]: Background color of a selected entry.
/// - [onHoverColor]: Background color of a hovered entry.
/// - [entryTextStyle]: Text style for dropdown options.
/// - [labelTextStyle] defines the text style for the label.
/// - [inputTextStyle]: Text style for the input box.
/// - [onFocusLabelColor] label color when the text field is focused.
/// - [inputPadding]: Padding inside the input box.
/// - [dialogPadding]: Padding inside the dropdown menu.
///
/// Use `copyWith` to modify specific properties or provide a new instance
/// to `ThemeData.extension`.
/// {@endtemplate}
class SteamDropdownTheme extends ThemeExtension<SteamDropdownTheme> {
  /// {@macro steam_dropdown_theme}
  const SteamDropdownTheme({
    required this.backgroundColor,
    required this.onSelectedColor,
    required this.onHoverColor,
    required this.labelTextStyle,
    required this.onFocusLabelColor,
    this.entryTextStyle,
    this.inputTextStyle,
    this.inputPadding = const EdgeInsets.only(left: 3, bottom: 3),
    this.dialogPadding = const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
  });

  /// The background color of the dropdown menu.
  final Color backgroundColor;

  /// The background color of a selected dropdown entry.
  final Color onSelectedColor;

  /// The background color of a hovered dropdown entry.
  final Color onHoverColor;

  /// The text style of dropdown menu entries.
  final TextStyle? entryTextStyle;

  /// The text style of the label.
  final TextStyle labelTextStyle;

  /// The text style of the dropdown input field.
  final TextStyle? inputTextStyle;

  /// The color of the label when the text field is focused.
  final Color onFocusLabelColor;

  /// The padding inside the input box.
  final EdgeInsets inputPadding;

  /// The padding inside the dropdown menu.
  final EdgeInsets dialogPadding;

  @override
  SteamDropdownTheme copyWith({
    Color? backgroundColor,
    TextStyle? labelTextStyle,
    Color? onSelectedColor,
    Color? onHoverColor,
    TextStyle? entryTextStyle,
    TextStyle? inputTextStyle,
    Color? onFocusLabelColor,
    EdgeInsets? inputPadding,
    EdgeInsets? dialogPadding,
  }) {
    return SteamDropdownTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      onSelectedColor: onSelectedColor ?? this.onSelectedColor,
      onHoverColor: onHoverColor ?? this.onHoverColor,
      entryTextStyle: entryTextStyle ?? this.entryTextStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      inputTextStyle: inputTextStyle ?? this.inputTextStyle,
      onFocusLabelColor: onFocusLabelColor ?? this.onFocusLabelColor,
      inputPadding: inputPadding ?? this.inputPadding,
      dialogPadding: dialogPadding ?? this.dialogPadding,
    );
  }

  @override
  SteamDropdownTheme lerp(
    ThemeExtension<SteamDropdownTheme>? other,
    double t,
  ) {
    if (other is! SteamDropdownTheme) return this;
    return SteamDropdownTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      onSelectedColor: Color.lerp(onSelectedColor, other.onSelectedColor, t)!,
      onHoverColor: Color.lerp(onHoverColor, other.onHoverColor, t)!,
      entryTextStyle: TextStyle.lerp(entryTextStyle, other.entryTextStyle, t),
      labelTextStyle: TextStyle.lerp(
        labelTextStyle,
        other.labelTextStyle,
        t,
      )!,
      inputTextStyle: TextStyle.lerp(inputTextStyle, other.inputTextStyle, t),
      onFocusLabelColor: Color.lerp(
        onFocusLabelColor,
        other.onFocusLabelColor,
        t,
      )!,
      inputPadding:
          EdgeInsets.lerp(inputPadding, other.inputPadding, t) ?? inputPadding,
      dialogPadding: EdgeInsets.lerp(dialogPadding, other.dialogPadding, t) ??
          dialogPadding,
    );
  }
}

/// Helper methods on [BuildContext] for the Flutter Steam.
extension SteamBuildContext on BuildContext {
  /// Returns the extension of type [T] from the context.
  ///
  /// Throws Exception if none is found.
  T steamThemeExtension<T>() {
    final theme = Theme.of(this);

    final ext = theme.extension<T>();

    if (ext == null) {
      throw Exception(
        'Cannot find extension $T on theme. Make sure to create a Flutter Steam'
        ' theme using flutterSteamTheme method.',
      );
    }

    return ext;
  }
}

/// Creates a Flutter Steam [ThemeData].
ThemeData flutterSteamTheme({
  Brightness brightness = Brightness.dark,
  SteamTheme steamTheme = const SteamTheme(
    primary: Color(0xFF4C5844), // Dark green (background)
    secondary: Color(0xFF5A6A50), // Lighter green (tabs and highlights)
    tertiary: Color(0xFF3E4637), // Lighter green (tabs and highlights)
    highlight: Color(0xFFBEB550), // Yellow/gold (accent/highlight)
    highlightMuted: Color(0xFF978630), // Low emphasis (accent/highlight)
    onPrimary: Color(0xFFFFFFFF), // High emphasis (titles, most important text)
    onPrimaryVariant: Color(0xFFD2DDCC), // Medium emphasis (normal text)
    onPrimaryMuted: Color(0xFF757E6D), // Low emphasis (less important values)
    shade: Color(0xFF757E6D), // Grey (shade, border or secondary elements)
  ),
}) {
  final containerTheme = SteamContainerTheme(
    backgroundColor: steamTheme.primary,
    primaryBorderColor: steamTheme.shade,
    secondaryBorderColor: steamTheme.tertiary,
  );

  final buttonTheme = SteamButtonTheme(backgroundColor: steamTheme.primary);

  final buttonIconTheme = SteamIconButtonTheme(
    backgroundColor: steamTheme.primary,
    iconColor: steamTheme.onPrimaryVariant,
  );

  final textFieldTheme = SteamTextFieldTheme(
    backgroundColor: steamTheme.tertiary,
    onFocusLabelColor: steamTheme.highlight,
    labelTextStyle: TextStyle(color: steamTheme.onPrimary),
    inputTextStyle: TextStyle(
      color: steamTheme.onPrimaryVariant,
      fontSize: 14,
    ),
    disabledBackgroundColor: steamTheme.tertiary.withAlpha(128),
    disabledTextStyle: TextStyle(
      color: steamTheme.onPrimaryMuted.withAlpha(128),
      fontSize: 14,
    ),
  );

  final dropdownTheme = SteamDropdownTheme(
    backgroundColor: steamTheme.tertiary,
    labelTextStyle: TextStyle(color: steamTheme.onPrimary),
    inputTextStyle: TextStyle(
      color: steamTheme.onPrimaryVariant,
      fontSize: 14,
    ),
    onFocusLabelColor: steamTheme.highlight,
    onSelectedColor: steamTheme.highlightMuted,
    onHoverColor: steamTheme.secondary,
  );

  return ThemeData(
    brightness: brightness,
    primaryColor: steamTheme.primary,
    highlightColor: steamTheme.highlight,
    extensions: [
      steamTheme,
      containerTheme,
      buttonTheme,
      buttonIconTheme,
      textFieldTheme,
      dropdownTheme,
    ],
  );
}
