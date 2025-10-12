import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamSlider)
Widget buildSteamSliderUseCase(BuildContext context) {
  return const _SteamSliderExample();
}

class _SteamSliderExample extends StatefulWidget {
  const _SteamSliderExample();

  @override
  State<_SteamSliderExample> createState() => _SteamSliderExampleState();
}

class _SteamSliderExampleState extends State<_SteamSliderExample> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Anti-Mass Spectrometer Power'),
            SteamSlider(
              min: 0,
              max: 105,
              value: _value,
              onChanged: (value) => setState(() => _value = value),
            ),
          ],
        ),
      ),
    );
  }
}
