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
          brightness: Brightness.light
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
                        IconButton(  // TODO replace with actual icon
                          hoverColor: Colors.transparent,
                          padding: EdgeInsets.all(0),
                          onPressed: () {}, 
                          icon: Image.asset('assets/GooseHawk_Logo_Transparent.png')
                          ), // FloatingActionButton
                        Expanded(
                          child: MoveWindow(),
                        ),
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

class LeftSide extends StatelessWidget { // ok so eventually you're going to havce an expanded widget with a listView sub widget and then a container widget that is on the same level as the expanded widget with settings
  const LeftSide({super.key});

  final _pages = const [ // fuck dart and fucking objects fucking pricks
    'Home',
    'Spending',
    'Budgeting',
    'Calendar',
  ];

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
              child: 
                Material(
                  child: ListView(
                    // selectedIndex: selectedIndex
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      for (var p in _pages)
                        ListTile(
                          // hoverColor: Colors.blue,
                          leading: Icon(Icons.circle), // TODO replace with actual icons
                          title: Text(p),
                          onTap: () {
                            print('clicked on $p');
                            // Handle navigation tap
                          },
                          // hoverColor: Theme.of(context).colorScheme.primary,
                        ),
                    ]
                  ),
                ), // ListView

              ), // Expanded
              ListTile( 
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {}
              )
            ],
        ), // Column
      ) // Container
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
          child: Column(
            children: [
              ],
          ), // Column
        ),
      ) // Center
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
      return Scaffold(
        body: Center(child: Text('Error loading data: $_error')),
      );
    }

    if (_data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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
            const Text('Accounts:', style: TextStyle(fontWeight: FontWeight.bold)),
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