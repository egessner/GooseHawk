import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import './main.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GooseHawkChangeNotifier>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final balanceboxWidth =
              constraints.maxWidth * .425; // 40% of available width
          final balanceboxHeight =
              constraints.maxHeight * .2; // 20% of available height
          final balanceboxpadWidth =
              constraints.maxWidth * .05; // 5% of available width
          final homepagespacerHeight =
              constraints.maxHeight * .05; // 5% of available height
          final accountsboxWidth =
              constraints.maxWidth * .9; // 90% of available width
          final accountsboxHeight =
              constraints.maxHeight * .5; // 40% of available
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // first the greeting of the day, this will be some helper function eventually I'm sure but for now it will say morning
              Card(
                elevation: 0,
                margin: EdgeInsets.all(8),
                shape: ContinuousRectangleBorder(),
                borderOnForeground: true,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  'Good morning,',
                  style: TextStyle(
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Scalable spacer between greeting and balance boxes
                  SizedBox(height: homepagespacerHeight),
                  // Next how much was spent this month and how much is left in the budget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Spent this month
                      BalanceBox(
                        title: 'Spent this month',
                        amount: '\$1,200', // TODO replace with real data
                        width: balanceboxWidth,
                        height: balanceboxHeight,
                        onTap: () {
                          appState.setCurrentPageIndex(1);
                        },
                      ),
                      // Scalable padding between the two boxes
                      SizedBox(width: balanceboxpadWidth),
                      // Left in budget
                      BalanceBox(
                        title: 'Left in budget',
                        amount: '\$2,134.56', // TODO replace with real data
                        width: balanceboxWidth,
                        height: balanceboxHeight,
                        onTap: () {
                          appState.setCurrentPageIndex(2);
                        },
                      ),
                    ],
                  ),
                  // Scalable spacer between balance boxes and accounts list
                  SizedBox(height: homepagespacerHeight),
                  // Finally the list of accounts
                  AccountBox(
                    width: accountsboxWidth,
                    height: accountsboxHeight,
                    onTap: () {
                      appState.setCurrentPageIndex(4);
                    },
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class BalanceBox extends StatelessWidget {
  final String title;
  final String amount;
  final double width;
  final double height;
  final VoidCallback onTap;

  const BalanceBox({
    super.key,
    required this.title,
    required this.amount,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer, // TODO this will be green if under budget red if over
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountBox extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onTap;

  const AccountBox({
    super.key,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Accounts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                // ListView(
                //   children: [
                //     // TODO erik, listen buddy, make this a ListView.builder, I know we don't get it yet but we will fella
                //     ListTile(
                //       title: Text('Checking'),
                //       subtitle: Text('US Bank'),
                //       trailing: Text('\$1,234.56'),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// fuck i hate all of it
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// just about all of this deserves to die
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
