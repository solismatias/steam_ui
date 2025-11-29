import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:steam_ui/steam_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steam UI Demo',
      debugShowCheckedModeBanner: false,
      theme: flutterSteamTheme(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SteamSingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const LoadingSection(),
                    const SizedBox(height: 50),
                    const EmployeeFormSection(),
                    const SizedBox(height: 50),
                    const RadioCheckboxSection(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RadioCheckboxSection extends StatefulWidget {
  const RadioCheckboxSection({super.key});

  @override
  State<RadioCheckboxSection> createState() => _RadioCheckboxSectionState();
}

enum LabSector { a, b, c, d }

class _RadioCheckboxSectionState extends State<RadioCheckboxSection> {
  bool _isChecked1 = false;
  bool _isChecked2 = true;
  bool _isChecked3 = true;
  LabSector? _sector = LabSector.a;

  @override
  Widget build(BuildContext context) {
    return SteamContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('System Status', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          SteamCheckboxTile(
            value: _isChecked1,
            onChanged: (value) => setState(() => _isChecked1 = value),
            label: 'Activate containment field',
          ),
          const SizedBox(height: 8),
          SteamCheckboxTile(
            value: _isChecked2,
            onChanged: (value) => setState(() => _isChecked2 = value),
            label: 'Authorize resonance cascade',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Awaiting input:'),
              const SizedBox(width: 8),
              SteamCheckbox(
                value: _isChecked3,
                onChanged: (value) => setState(() => _isChecked3 = value),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Divert energy to:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          for (var sector in LabSector.values) ...[
            SteamRadioTile<LabSector>(
              label: 'Sector ${sector.name.toUpperCase()}',
              value: sector,
              groupValue: _sector,
              onChanged: (LabSector? value) {
                setState(() {
                  _sector = value;
                });
              },
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class LoadingSection extends StatefulWidget {
  const LoadingSection({super.key});

  @override
  State<LoadingSection> createState() => _LoadingSectionState();
}

class _LoadingSectionState extends State<LoadingSection> {
  late Timer _timer;
  double _progress = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += Random().nextDouble() * 3;
        if (_progress >= 100) {
          _progress = 100;
          _isLoading = false;
          timer.cancel();
          Timer(const Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                _progress = 0;
                _isLoading = true;
              });
              _startLoading();
            }
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steamTheme = Theme.of(context).extension<SteamTheme>();

    return SteamContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isLoading ? 'Analyzing crystal...' : 'Analysis complete!',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SteamContainer(
                    padding: const EdgeInsets.all(6),
                    backgroundColor: steamTheme?.tertiary,
                    alternateBorderColor: true,
                    child: SteamProgressBar(value: _progress),
                  ),
                ),
                const SizedBox(width: 8),
                SteamButton(
                  onPressed: () {
                    setState(() {
                      _progress = 0;
                      _isLoading = true;
                    });
                    _timer.cancel();
                    _startLoading();
                  },
                  child: const Text('Restart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeFormSection extends StatelessWidget {
  const EmployeeFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SteamContainer(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          EmployeeFormHeader(),
          SizedBox(height: 16),
          EmployeeFormContent(),
          SizedBox(height: 16),
          EmployeeFormActions(),
        ],
      ),
    );
  }
}

class EmployeeFormHeader extends StatelessWidget {
  const EmployeeFormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Employee of the Month',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SteamIconButton(icon: Icons.close, onPressed: () {}),
      ],
    );
  }
}

class EmployeeFormContent extends StatelessWidget {
  const EmployeeFormContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SteamContainer(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 700) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                EmployeeAvatar(),
                SizedBox(height: 32),
                EmployeeForm(),
              ],
            );
          }
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: EmployeeAvatar()),
              SizedBox(width: 32),
              Expanded(flex: 7, child: EmployeeForm()),
            ],
          );
        },
      ),
    );
  }
}

class EmployeeAvatar extends StatelessWidget {
  const EmployeeAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 250,
          decoration: BoxDecoration(
            color: Theme.of(context).extension<SteamTheme>()?.secondary,
            borderRadius: BorderRadius.circular(8),
          ),

          child: const Icon(Icons.person, size: 100, color: Colors.white54),
        ),
        const SizedBox(height: 16),
        const Text(
          'Gordon Freeman',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Black Mesa Research Facility',
          style: TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }
}

class EmployeeForm extends StatefulWidget {
  const EmployeeForm({super.key});

  @override
  State<EmployeeForm> createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _sectorController;
  late Timer _meterTimer;
  double _meterLevel = 0;
  double _sliderValue = 105;

  static const List<String> _positions = [
    'Theoretical Physicist',
    'Research Associate',
    'Security Guard',
    'Hazardous Environment Supervisor',
    'Lambda Core Technician',
    'Anti-Mass Spectrometer Operator',
    'Sector C Team Leader',
    'Xen Biologist',
    'Materials Handler',
    'Ordinance Storage Supervisor',
    'H.E.V. Suit Technician',
    'Monorail Operator',
    'Hydro-Electric Dam Engineer',
    'Satellite Delivery Rocket Specialist',
    'Coolant System Engineer',
    'High-Energy Physics Researcher',
    'Anomalous Materials Lab Assistant',
    'Decontamination Unit Operator',
    'Containment Unit Specialist',
    '"Forget About Freeman" Committee',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Gordon');
    _lastNameController = TextEditingController(text: 'Freeman');
    _sectorController = TextEditingController(text: 'Anomalous Materials');
    _startMeterSimulation();
  }

  void _startMeterSimulation() {
    _meterTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        final random = Random();
        final baseLevel = 15 + random.nextDouble() * 10;
        final spike = random.nextDouble() < 0.1 ? random.nextDouble() * 30 : 0;
        _meterLevel = (baseLevel + spike).clamp(0, 100);
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _sectorController.dispose();
    _meterTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SteamTextField(label: const Text('Name'), controller: _nameController),
        const SizedBox(height: 16),
        SteamTextField(
          label: const Text('Last Name'),
          controller: _lastNameController,
        ),
        const SizedBox(height: 16),
        SteamTextField(
          label: const Text('Sector'),
          controller: _sectorController,
          enabled: false,
        ),
        const SizedBox(height: 16),
        SteamDropdown(
          label: const Text('Position'),
          initialValue: 'Theoretical Physicist',
          entries: [
            for (var position in _positions)
              SteamDropdownMenuEntry(value: position, label: position),
          ],
        ),
        const SizedBox(height: 16),
        SteamContainer(
          alternateBorderColor: true,
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Spectrometer Energy Levels'),
                  Text('${_meterLevel.round()}%'),
                ],
              ),
              const SizedBox(height: 8),
              SteamMeter(value: _meterLevel),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Overhead capacitors'),
                Text('${_sliderValue.round()}%'),
              ],
            ),
            const SizedBox(height: 8),
            SteamSlider(
              max: 105,
              value: _sliderValue,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class EmployeeFormActions extends StatelessWidget {
  const EmployeeFormActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SteamButton(onPressed: () {}, child: const Text('OK')),
        const SizedBox(width: 8),
        SteamButton(onPressed: () {}, child: const Text('Cancel')),
        const SizedBox(width: 8),
        SteamButton(onPressed: () {}, child: const Text('Apply')),
      ],
    );
  }
}
