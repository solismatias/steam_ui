import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamProgressBar)
Widget buildSteamProgressBarUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: SteamProgressBar(
        value: context.knobs.double.slider(
          label: 'Value',
          min: 0,
          max: 100,
          initialValue: 50,
        ),
      ),
    ),
  );
}
