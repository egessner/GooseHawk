import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(GooseHawk());
}

class GooseHawk extends StatelessWidget {
  const GooseHawk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFF27A00)),
        brightness: Brightness.light,
        // useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 30,
              child: Container(
                // color: Theme.of(context).colorScheme.primary,
                child: WindowTitleBarBox(
                  child: Row(
                    children: [
                      IconButton(
                        // TODO replace with actual icon
                        hoverColor: Colors.transparent,
                        padding: EdgeInsets.all(0),
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/GooseHawk_Logo_Transparent.png',
                        ),
                      ), // FloatingActionButton
                      Expanded(child: MoveWindow()),
                      WindowButtons(),
                    ],
                  ), // Row
                ),
              ), // WindowTitleBarBox
            ), // SizedBox
            Expanded(
              child: Row(
                children: const [
                  LeftSide(), // TODO change left side to a NavigationDrawer!!!
                  RightSide(),
                ],
              ), // Row
            ), // Expanded
          ],
        ), // Column
      ), //Scaffold
    ); // MaterialApp
  }
}

const List<NavigationRailDestination> navRailDestinations = [
  NavigationRailDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: Text('Home'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.attach_money_outlined),
    selectedIcon: Icon(Icons.attach_money),
    label: Text('Spending'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.calculate_outlined),
    selectedIcon: Icon(Icons.calculate),
    label: Text('Budgeting'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.calendar_today_outlined),
    selectedIcon: Icon(Icons.calendar_today),
    label: Text('Calendar'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.account_balance_outlined),
    selectedIcon: Icon(Icons.account_balance),
    label: Text('Accounts'),
  ),
];

class LeftSide extends StatefulWidget {
  const LeftSide({super.key});

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  // var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Column(
          children: [
            // Text('Left Side - Navigation'),
            Expanded(
              child: NavigationRail(
                selectedIndex: _selectedIndex,
                extended: true,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                destinations: [
                  for (var dest in navRailDestinations)
                    NavigationRailDestination(
                      icon: dest.icon,
                      selectedIcon: dest.selectedIcon,
                      label: dest.label,
                    ),
                ],
              ), // NavigationRail
            ), // Expanded
            SizedBox(
              width: 200,
              child: FloatingActionButton.extended(
                shape: ContinuousRectangleBorder(),
                icon: Icon(Icons.settings),
                label: Text('Settings'),
                onPressed: () {}, // TODO make this go to settings page
              ),
            ),
          ],
        ), // Column
      ), // Container
    ); // SizedBox
  }
}

// I guess we can do a gradient later on? Take a look at https://www.youtube.com/watch?v=bee2AHQpGK4
class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Center(
          child: Column(children: [
              ],
          ), // Column
        ),
      ), // Center
    ); // Expanded
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}

/// ignore all this bullshit below for now it will probably get deleted anyway i have literally no idea what im doing with flutter. We're LEARNING FUCK!!

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? _data;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  Future<void> _loadSampleData() async {
    try {
      final text = await rootBundle.loadString('lib/sampleData.json');
      final decoded = jsonDecode(text) as Map<String, dynamic>;
      setState(() => _data = decoded);
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(body: Center(child: Text('Error loading data: $_error')));
    }

    if (_data == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final totalSpent = _data!['totalSpentThisMonth'] as String? ?? '';
    final totalLeft = _data!['totalLeftInBudget'] as String? ?? '';
    final accounts = (_data!['accounts'] as List<dynamic>?) ?? <dynamic>[];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total spent this month: $totalSpent'),
            const SizedBox(height: 8),
            Text('Total left in budget: $totalLeft'),
            const SizedBox(height: 16),
            const Text(
              'Accounts:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...accounts.map((a) {
              final map = a as Map<String, dynamic>;
              return ListTile(
                title: Text(map['name'] as String? ?? ''),
                subtitle: Text(map['type'] as String? ?? ''),
                trailing: Text(map['balance'] as String? ?? ''),
              );
            }),
          ],
        ),
      ),
    );
  }
}

/**
 * Ok so we're going to try and make this look less shitty and then we will refactor into separate files.
 */
