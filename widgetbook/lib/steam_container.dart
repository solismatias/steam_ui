import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamContainer)
Widget buildSteamContainerUseCase(BuildContext context) {
  return Center(
    child: const SteamContainer(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Center(child: Text('A highly trained container')),
      ),
    ),
  );
}
