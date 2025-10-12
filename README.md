# Steam Ui

UI library inspired by the classic Steam interface from the early 2000s (Work in progress)

![Screenshot from 2025-06-16 22-35-08](https://github.com/user-attachments/assets/c2a1a9c4-c7e0-4375-99cd-98cda2c58a58)




## Installation 💻

❗ To use Steam UI, you must have the [Flutter SDK][flutter_install_link] installed on your machine.

Since this package is not available on pub.dev, you can install it using one of the following methods:

1. **Clone the repository**

    ```sh
    git clone https://github.com/solismatias/steam_ui.git
    ```

    Then, add it to your `pubspec.yaml`:

    ```yaml
    dependencies:
      steam_ui:
        path: ../steam_ui
    ```

2. **Use the GitHub repository directly**

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
 - SteamLoader



