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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
        color: CustomColors.onPrimary3,
        width: 1,
      ),
      left: BorderSide(
        color: CustomColors.onPrimary3,
        width: 1,
      ),
      right: BorderSide(
        color: CustomColors.highlightSecondary,
        width: 1,
      ),
      bottom: BorderSide(
        color: CustomColors.highlightSecondary,
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
            style: const TextStyle(color: CustomColors.onPrimary3),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 7,
          child: Text(
            value,
            style: const TextStyle(color: CustomColors.onPrimary2),
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
  static const Color primary = Color(0xFF4C5844);
  static const Color highlight = Color(0xFF968830);
  static const Color highlightSecondary = Color(0xFF282E22);
  static const Color primaryContainer = Color(0xFF3E4637);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimary2 = Color(0xFFD2DDCC);
  static const Color onPrimary3 = Color(0xFFA3AF9B);
}
