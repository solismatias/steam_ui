import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamIconButton)
Widget buildSteamIconButtonUseCase(BuildContext context) {
  return Center(
    child: SteamIconButton(icon: Icons.add, onPressed: () {}),
  );
}
