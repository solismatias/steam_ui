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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const LoadingSection(),
              const SizedBox(height: 50),
              const EmployeeFormSection(),
              const SizedBox(height: 50),
            ],
          ),
        ),
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

    return SizedBox(
      width: 600,
      child: SteamContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isLoading ? 'Loading...' : 'Complete!',
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
                      child: SteamLoader(value: _progress),
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
      ),
    );
  }
}

class EmployeeFormSection extends StatelessWidget {
  const EmployeeFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SteamContainer(
      width: 800,

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
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: EmployeeAvatar()),
          SizedBox(width: 32),
          Expanded(flex: 7, child: EmployeeForm()),
        ],
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
  late Timer _audioTimer;
  double _audioLevel = 0;
  double _satisfactionLevel = 50;

  static const List<String> _positions = [
    'Software Engineer',
    'Data Scientist',
    'Product Manager',
    'Theoretical Physicist',
    'Quantum Mechanic',
    'AI Researcher',
    'Cybersecurity Analyst',
    'Nanotechnology Specialist',
    'Robotics Engineer',
    'Spacecraft Pilot',
    'Quantum Programmer',
    'Bioinformatics Analyst',
    'Augmented Reality Designer',
    'Virtual Reality Architect',
    'Galactic Cartographer',
    'Neural Interface Developer',
    'Cryogenics Technician',
    'Fusion Reactor Operator',
    'Terraforming Engineer',
    'Exoplanet Explorer',
    'Time Travel Consultant',
    'Android Ethicist',
    'Genetic Modification Expert',
    'Plasma Weapons Specialist',
    'Antimatter Containment Engineer',
    'Holodeck Programmer',
    'Warp Drive Mechanic',
    'Extraterrestrial Linguist',
    'Drone Swarm Coordinator',
    'Cybernetic Implant Surgeon',
    'Dark Matter Researcher',
    'Stellar Engineer',
    'Gravity Manipulation Specialist',
    'Teleportation Systems Analyst',
    'Energy Shield Technician',
    'Space Elevator Operator',
    'AI Ethics Officer',
    'Sentient Robot Liaison',
    'Deep Space Miner',
    'Asteroid Mining Supervisor',
    'Zero-G Sports Coach',
    'Galactic Law Enforcer',
    'Space Station Administrator',
    'Planetary Defense Strategist',
    'Cloning Facility Manager',
    'Memory Augmentation Specialist',
    'Simulated Reality Tester',
    'Nanobot Swarm Controller',
    'Biohacker',
    'Quantum Encryption Analyst',
    'Cosmic Radiation Specialist',
    'Starship Systems Integrator',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Gordon');
    _lastNameController = TextEditingController(text: 'Freeman');
    _sectorController = TextEditingController(text: 'Anomalous Materials');
    _startAudioMeterSimulation();
  }

  void _startAudioMeterSimulation() {
    _audioTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        final random = Random();
        final baseLevel = 15 + random.nextDouble() * 10;
        final spike = random.nextDouble() < 0.1 ? random.nextDouble() * 30 : 0;
        _audioLevel = (baseLevel + spike).clamp(0, 100);
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _sectorController.dispose();
    _audioTimer.cancel();
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
        SteamDropdownMenu(
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
                  const Text('Microphone Input (fake)'),
                  Text('${_audioLevel.round()}%'),
                ],
              ),
              const SizedBox(height: 8),
              SteamAudioMeter(value: _audioLevel),
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
                const Text('Satisfaction level'),
                Text('${_satisfactionLevel.round()}%'),
              ],
            ),
            const SizedBox(height: 8),
            SteamSlider(
              max: 100,
              value: _satisfactionLevel,
              onChanged: (value) {
                setState(() {
                  _satisfactionLevel = value;
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
