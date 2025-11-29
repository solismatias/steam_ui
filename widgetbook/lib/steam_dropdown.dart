import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamDropdown)
Widget buildSteamDropdownMenuUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: const SteamDropdown(
        label: Text('Position'),
        entries: [
          SteamDropdownMenuEntry(
            value: 'anomalous_material',
            label: 'Anomalous Materials',
          ),
          SteamDropdownMenuEntry(
            value: 'advanced_biological_research',
            label: 'Advanced Biological Research',
          ),
          SteamDropdownMenuEntry(
            value: 'lambda_complex',
            label: 'Lambda Complex',
          ),
        ],
      ),
    ),
  );
}
