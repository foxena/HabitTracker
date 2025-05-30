import 'package:flutter/material.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MainScaffold(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = [
    DashboardScreen(),
    Center(child: Text('Habits Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Settings Page', style: TextStyle(fontSize: 24))),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 220,
            color: Colors.green.shade700,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  'Habit Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                _SidebarItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  selected: _selectedIndex == 0,
                  onTap: () => _onNavTap(0),
                ),
                _SidebarItem(
                  icon: Icons.list,
                  label: 'Habits',
                  selected: _selectedIndex == 1,
                  onTap: () => _onNavTap(1),
                ),
                _SidebarItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  selected: _selectedIndex == 2,
                  onTap: () => _onNavTap(2),
                ),
                const Spacer(),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? Colors.green.shade900 : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatCard(
        icon: Icons.check_circle,
        label: 'Habits Completed',
        value: '3',
      ),
      _StatCard(
        icon: Icons.timelapse,
        label: 'Streak',
        value: '5 days',
      ),
      _StatCard(
        icon: Icons.star,
        label: 'Best Streak',
        value: '12 days',
      ),
      _StatCard(
        icon: Icons.today,
        label: 'Habits Today',
        value: '5',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: stats,
            ),
            const SizedBox(height: 32),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Read for 20 minutes'),
                  subtitle: Text('Completed at 8:30 AM'),
                ),
                ListTile(
                  leading: Icon(Icons.check),
                  title: Text('Morning run'),
                  subtitle: Text('Completed at 7:00 AM'),
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Meditate'),
                  subtitle: Text('Not completed yet'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}