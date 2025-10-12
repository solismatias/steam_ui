import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamDropdownMenu)
Widget buildSteamDropdownMenuUseCase(BuildContext context) {
  return Center(
    child: SizedBox(
      width: 300,
      child: const SteamDropdownMenu(
        label: Text('Sector'),
        entries: [
          SteamDropdownMenuEntry(
            value: 'anomalous_material',
            label: 'Anomalous Material',
          ),
          SteamDropdownMenuEntry(
            value: 'high_energy_laser',
            label: 'High Energy Laser',
          ),
          SteamDropdownMenuEntry(
            value: 'hazardous_environment',
            label: 'Hazardous Environment',
          ),
        ],
      ),
    ),
  );
}
