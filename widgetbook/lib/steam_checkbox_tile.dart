import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamCheckboxTile)
Widget steamCheckboxTile(BuildContext context) {
  return Center(
    child: SteamCheckboxTile(
      value: context.knobs.boolean(label: 'Checked', initialValue: true),
      onChanged: (value) {},
      label: context.knobs.string(
        label: 'Label',
        initialValue: 'Checkbox Label',
      ),
    ),
  );
}
