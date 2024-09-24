import 'package:example/src/theme.dart';
import 'package:example/src/widgets/steam_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: flutterSteamTheme(),
      home: const _NewExample(),
    );
  }
}

class _NewExample extends StatelessWidget {
  const _NewExample();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(),
          const Text('0'),
          // const SteamContainer(
          //   width: 300,
          //   height: 300,
          // ),
          const SteamContainer(
            width: 300,
            height: 300,
            child: Center(
              child: SteamContainer(
                width: 150,
                height: 150,
                child: Center(child: SteamContainer()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    var border = const Border(
      top: BorderSide(
        color: CustomColors.onPrimaryMuted,
        width: 1,
      ),
      left: BorderSide(
        color: CustomColors.onPrimaryMuted,
        width: 1,
      ),
      right: BorderSide(
        color: CustomColors.accent,
        width: 1,
      ),
      bottom: BorderSide(
        color: CustomColors.accent,
        width: 1,
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 139, 139, 139),
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              color: CustomColors.primary,
              border: border,
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 500,
                width: 400,
                child: Column(
                  children: [
                    _Header(
                      title: 'Información de la partida',
                    ),
                    SizedBox(height: 10),
                    _RowValue(
                      label: 'Nombre',
                      value: '#03 Game Name | Lorem Ipsum',
                    ),
                    _RowValue(
                      label: 'Dirección IP',
                      value: '11.222.33.4444:55555',
                    ),
                    _RowValue(
                      label: 'Partida',
                      value: 'Deathmatch',
                    ),
                    _RowValue(
                      label: 'Map',
                      value: 'Crossfire',
                    ),
                    _RowValue(
                      label: 'Jugadores',
                      value: '1 / 20',
                    ),
                    _RowValue(
                      label: 'Sistema antitrampas',
                      value: 'Seguro',
                    ),
                    _RowValue(
                      label: 'Latencia',
                      value: '23',
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class _RowValue extends StatelessWidget {
  const _RowValue({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            '$label:',
            style: const TextStyle(color: CustomColors.onPrimaryMuted),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 7,
          child: Text(
            value,
            style: const TextStyle(color: CustomColors.onPrimaryVariant),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          const Icon(Icons.abc, color: CustomColors.onPrimary),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(color: CustomColors.onPrimary),
          ),
          const Spacer(),
          const Icon(Icons.close, color: CustomColors.onPrimary)
        ],
      ),
    );
  }
}

class CustomColors {
  static const Color primary = Color(0xFF4C5844); // Dark green (background)
  static const Color secondary = Color(0xFF5A6A50); // Lighter green (tabs and highlights)
  static const Color tertiary = Color(0xFF3E4637); // Lighter green (tabs and highlights)
  static const Color accent = Color(0xFF968830); // Yellow/gold (accent/highlight)
  static const Color onPrimary = Color(0xFFFFFFFF); // High emphasis (titles, most important text)
  static const Color onPrimaryVariant = Color(0xFFD2DDCC); // Medium emphasis (normal text)
  static const Color onPrimaryMuted = Color(0xFFA3AF9B); // Low emphasis (labels, less important values)
  static const Color shade = Color(0xFFA3AF9B); // Grey (shade, border or secondary elements)
}

// ignore: unused_element
class _Container extends StatelessWidget {
  const _Container();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CustomColors.primary,
        border: Border(
          top: BorderSide(
            color: CustomColors.onPrimaryMuted,
            width: 1,
          ),
          left: BorderSide(
            color: CustomColors.onPrimaryMuted,
            width: 1,
          ),
          right: BorderSide(
            color: CustomColors.accent,
            width: 1,
          ),
          bottom: BorderSide(
            color: CustomColors.accent,
            width: 1,
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: SizedBox(),
      ),
    );
  }
}
