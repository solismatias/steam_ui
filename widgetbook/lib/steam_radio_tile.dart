import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamRadioTile)
Widget steamRadioTile(BuildContext context) {
  return Center(
    child: SteamRadioTile(
      value: context.knobs.boolean(label: 'Value', initialValue: true),
      groupValue: context.knobs.boolean(
        label: 'Group Value',
        initialValue: true,
      ),
      onChanged: (value) {},
      label: context.knobs.string(label: 'Label', initialValue: 'Radio Label'),
    ),
  );
}
