import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const GooseHawk());
}

class GooseHawk extends StatelessWidget {
  const GooseHawk({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        title: 'GooseHawk',
        theme: ThemeData(
          /* TODO rework all of these, THEY SUCK!! */
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(
            primary: Color(0xFF0A2342),
            onPrimary: Colors.white,
            primaryContainer: Color.fromARGB(19, 10, 35, 66),
            surface: Color.fromARGB(100, 10, 35, 66),
            secondary: Color(0xFFF5771a),
            secondaryContainer: Color.fromARGB(19, 245, 117, 26),
          ),
        ),
        home: AppBar(),
      ),
    );
  }
}

class AppState extends ChangeNotifier {}

/// A Home page that uses tabs at the top for navigation.
class AppBar extends StatefulWidget {
  const AppBar({super.key});

  @override
  State<AppBar> createState() => _AppBarState();
}

/// I'm really not sure if TabBar is the right widget to use here. Thinking we use a AppBar instead, later Erik issue
class _AppBarState extends State<AppBar> {
  final _pages = const [
    Center(child: Text('Home')),
    Center(child: Text('Spending')),
    Center(child: Text('Budgeting')),
    Center(child: Text('Calendar')),
    Center(child: Text('Settings')),
  ];

  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: hover ? const Size.fromHeight(70) : 
          const Size.fromHeight(kToolbarHeight),
          child: SafeArea(
            child: Material(
              // color: Theme.of(context).colorScheme.primary,
              child: MouseRegion(
                onEnter:(e) => setState(() {hover = true;}),
                onExit: (e) => setState(() {hover = false;}),
                child: TabBar(
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  labelColor: Theme.of(context).colorScheme.secondary,
                  unselectedLabelColor: Theme.of( context).colorScheme.onPrimary,
                    tabs: hover ? const [
                      Tab(icon: Icon(Icons.home), text: 'Home'),
                      Tab(icon: Icon(Icons.attach_money_outlined), text: 'Spending'),
                      Tab(icon: Icon(Icons.calculate_outlined), text: 'Budgeting'),
                      Tab(icon: Icon(Icons.calendar_month_outlined), text: 'Calendar'),
                      Tab(icon: Icon(Icons.settings), text: 'Settings'),
                    ] : const [
                      Tab(icon: Icon(Icons.home)),
                      Tab(icon: Icon(Icons.attach_money_outlined)),
                      Tab(icon: Icon(Icons.calculate_outlined)),
                      Tab(icon: Icon(Icons.calendar_month_outlined)),
                      Tab(icon: Icon(Icons.settings))
                    ],
                  ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            Center(child: Text('Spending')),
            Center(child: Text('Budgeting')),
            Center(child: Text('Calendar')),
            Center(child: Text('Settings')),
          ],
        ),
      ),
    );
  }
}


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