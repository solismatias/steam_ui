import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamPressable)
Widget buildSteamPressableUseCase(BuildContext context) {
  return Center(
    child: SteamPressable(
      onPressed: () {},
      child: const Text('Press this text to stop resonace cascade!'),
    ),
  );
}
