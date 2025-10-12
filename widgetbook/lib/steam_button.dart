import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamButton)
Widget buildSteamButtonUseCase(BuildContext context) {
  return Center(
    child: SteamButton(onPressed: () {}, child: Text('Press Me!')),
  );
}
