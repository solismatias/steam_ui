import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: SteamSingleChildScrollView)
Widget buildSteamSingleChildScrollViewUseCase(BuildContext context) {
  return SteamSingleChildScrollView(
    child: Column(
      children: [
        Text('Test Subjects', style: Theme.of(context).textTheme.headlineSmall),
        ...List.generate(150, (index) => Text('Subject $index')),
      ],
    ),
  );
}
