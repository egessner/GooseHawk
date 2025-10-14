import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import './main.dart';
import './sampledata.dart' as sampledata;

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<GooseHawkChangeNotifier>();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
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
              constraints.maxHeight * .55; // 40% of available
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // first the greeting of the day, this will be some helper function eventually I'm sure but for now it will say morning
              Card(
                elevation: 0,
                margin: EdgeInsets.all(8),
                shape: ContinuousRectangleBorder(),
                borderOnForeground: true,
                color: colorScheme.primaryContainer,
                child: Text(
                  'Good morning,',
                  style: TextStyle(
                    fontSize: 24,
                    // fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500
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
                  ),
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
    final colorScheme = Theme.of(context).colorScheme;
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
                    fontSize: 18,
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  amount,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: colorScheme
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
    var _accountData = sampledata.sampleAccountData;
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      height: height,
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
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _accountData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var _curAccount = _accountData[index];
                    return InkWell(
                      onTap: onTap,
                      child: Card(
                        color: colorScheme.surfaceContainer,
                        child: ListTile(
                          // Account name
                          title: Text(
                            _curAccount.account,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          // Amount in account
                          trailing: Text(
                            _curAccount.amount
                                .toString(), // no $$ rn but we will format the data elsewhere
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          // Account sourcee
                          subtitle: Text(
                            _curAccount.accountSource,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

