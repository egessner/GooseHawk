import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bitsdojo_window/bitsdojo_window.dart';
import './homepage.dart' as _HomePage;
import './devpage.dart' as _DevPage;

void main() {
  runApp(GooseHawk());
}

class GooseHawk extends StatelessWidget {
  const GooseHawk({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GooseHawkChangeNotifier(),
      child: MaterialApp(
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
                child: WindowTitleBarBox(
                  child: Row(
                    children: [
                      IconButton(
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
                ), // WindowTitleBarBox
              ), // SizedBox
              Expanded(
                child: Row(
                  children: const [
                    LeftSide(),
                    RightSide(),
                  ],
                ), // Row
              ), // Expanded
            ],
          ), // Column
        ), //Scaffold
      ),
    ); // MaterialApp
  }
}

class GooseHawkChangeNotifier extends ChangeNotifier { // i dont really know how change notifier provider works yet
  // Add your state variables and methods here
  var currentPageIndex = 0; // HomePage

  void setCurrentPageIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }
}

class GooseHawkPageDestination{
  final Icon icon;
  final Icon selectedIcon;
  final Text label;
  final Widget page;

  const GooseHawkPageDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.page,
  });
}

const List<GooseHawkPageDestination> navRailDestinations = [
  GooseHawkPageDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: Text('Home'),
    page: _HomePage.HomePage2(),
  ),
  GooseHawkPageDestination(
    icon: Icon(Icons.attach_money_outlined),
    selectedIcon: Icon(Icons.attach_money),
    label: Text('Spending'),
    page: Placeholder(),
  ),
  GooseHawkPageDestination(
    icon: Icon(Icons.calculate_outlined),
    selectedIcon: Icon(Icons.calculate),
    label: Text('Budgeting'),
    page: Placeholder(),
  ),
  GooseHawkPageDestination(
    icon: Icon(Icons.calendar_today_outlined),
    selectedIcon: Icon(Icons.calendar_today),
    label: Text('Calendar'),
    page: Placeholder(),
  ),
  GooseHawkPageDestination(
    icon: Icon(Icons.account_balance_outlined),
    selectedIcon: Icon(Icons.account_balance),
    label: Text('Accounts'),
    page: Placeholder(),
  ),
  GooseHawkPageDestination(
    icon: Icon(Icons.plumbing_outlined),
    selectedIcon: Icon(Icons.plumbing),
    label: Text('DevPage'),
    page: Placeholder(),
  ),
];

class LeftSide extends StatefulWidget {
  const LeftSide({super.key});

  @override
  State<LeftSide> createState() => _LeftSideState();
}

class _LeftSideState extends State<LeftSide> {
  int _selectedIndex = 0; // TODO Redundent to have this set to 0?
  NavigationRailLabelType labelType = NavigationRailLabelType.all;

  // var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GooseHawkChangeNotifier>();
    _selectedIndex = appState.currentPageIndex;
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
                    appState.setCurrentPageIndex(index);
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
              child: FloatingActionButton.extended( // TODO change this to an inkwell its better
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
class RightSide extends StatefulWidget {
  const RightSide({super.key});

  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GooseHawkChangeNotifier>();
    var currentPage = navRailDestinations[appState.currentPageIndex].page;
    return Expanded(
      child: currentPage, // Center
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
