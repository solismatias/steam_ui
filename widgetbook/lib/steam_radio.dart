import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamRadio)
Widget steamRadio(BuildContext context) {
  return Center(
    child: SteamRadio(
      value: context.knobs.boolean(label: 'Value', initialValue: true),
      groupValue: context.knobs.boolean(
        label: 'Group Value',
        initialValue: true,
      ),
      onChanged: (value) {},
    ),
  );
}
