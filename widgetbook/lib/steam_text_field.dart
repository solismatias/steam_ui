import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamTextField)
Widget buildSteamTextFieldUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: const SteamTextField(label: Text('Username')),
    ),
  );
}
