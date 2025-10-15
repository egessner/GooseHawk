import 'package:flutter/material.dart';
import './main.dart';

/**
 * Use this page to make really shitty looking stuff thats just for testing
 */
class Devpage extends StatefulWidget {
  const Devpage({super.key});

  @override
  State<Devpage> createState() => _DevpageState();
}

class _DevpageState extends State<Devpage> {
  late final TextEditingController _clientID;
  late final TextEditingController _secretKey;

  void initState() {
    super.initState();
    _clientID = TextEditingController();
    _secretKey = TextEditingController();
  }

  var rawText = '';
  var bonusText = '';

  void updateRawText(newText) {
    setState(() {
      rawText = newText;
    });
  }

  void updateBonusText(newText) {
    setState(() {
      bonusText = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Row(
          children: [
            // input column
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  // Client ID text box
                  TextField(
                    controller: _clientID,
                    decoration: const InputDecoration(
                      labelText: 'Client ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  // secret key text box
                  TextField(
                    controller: _secretKey,
                    decoration: const InputDecoration(
                      labelText: 'Secret Key',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // probably run some script
                      // public token is returned
                    },
                    child: Text('Create Item'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // 4 import things here
                      // has_more tells us if we need to update DBs
                      // next curser points us at our latest transaction so we only pull new ones
                      // Accounts gives us all of our account data for an account
                      // added gives us transactions
                    },
                    child: Text('Transactions sync'),
                  ),
                ],
              ),
            ),
            // output column
            Expanded(
              child: Column(
                children: [
                  // Raw text
                  Text('Raw Text'),
                  SizedBox(
                    height: 300, 
                    child: 
                      SingleChildScrollView(
                        child: 
                          Text(rawText),
                      )
                    ),
                    SizedBox(height: 8),
                    Text('Bonus Text'),
                  SizedBox(
                    height: 300, 
                    child: 
                      SingleChildScrollView(
                        child: 
                          Text(bonusText),
                      )
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
