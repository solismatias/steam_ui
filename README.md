# Steam Ui

UI library inspired by the classic Steam interface from the early 2000s (Work in progress)

<img width="963" height="840" alt="saitam dev_steam_ui_example" src="https://github.com/user-attachments/assets/20c2d556-34f8-440f-b1f8-976f9065953c" />

## Demos

- [Example App](https://saitam.dev/steam_ui/example)
- [Widget Catalog](https://saitam.dev/steam_ui/catalog/)

## Installation

To use Steam UI, you must have the [Flutter SDK][flutter_install_link] installed on your machine.

### Option A: Install via pub.dev (Recommended)

Run this command:

```bash
flutter pub add steam_ui
```

### Option B: Install via GitHub

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  steam_ui:
    git:
      url: https://github.com/solismatias/steam_ui.git
```

   ---

## Set up

```dart
import 'package:steam_ui/steam_ui.dart';

MaterialApp(
  theme: flutterSteamTheme(),
);
````
   ---
## Widgets

 - SteamContainer
 - SteamButton
 - SteamIconButton
 - SteamTextField
 - SteamDropdown
 - SteamSingleChildScrollview
 - SteamMeter
 - SteamProgressBar
 - SteamCheckbox
 - SteamCheckboxTile
 - SteamRadio
 - SteamRadioTile
 - SteamSlider
 - SteamScrollbar
 - SteamPressable



[flutter_install_link]: https://docs.flutter.dev/get-started/install
