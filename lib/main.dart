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
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 30,
                child: WindowTitleBarBox(
                  child: Row(
                    children: [
                      FloatingActionButton(  // TODO replace with actual icon
                        backgroundColor: Colors.transparent,
                        // focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        hoverElevation: 0,
                        elevation: 0,
                        onPressed: () {}, 
                        child: Icon(Icons.home)
                        ), // FloatingActionButton
                      Expanded(
                        child: MoveWindow(),
                      ),
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
      ); // MaterialApp
  }
}

class LeftSide extends StatelessWidget { // ok so eventually you're going to havce an expanded widget with a listView sub widget and then a container widget that is on the same level as the expanded widget with settings
  const LeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Container(
        color: Colors.blueGrey, // TODO placeholder just so you can see the fucking thing
        // child: Column(
        //   children: [          
        //     Text('Left Side - Navigation')
        //     ],
        // ),
      )
    );
  }
}

// I guess we can do a gradient later on? Take a look at https://www.youtube.com/watch?v=bee2AHQpGK4
class RightSide extends StatelessWidget {
  const RightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          children: [
            ],
        ), // Column
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