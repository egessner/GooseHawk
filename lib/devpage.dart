import 'package:flutter/material.dart';
import './Plaid Sandbox/plaidcreateitem.dart' as createItem;
import './Plaid Sandbox/transactionssync.dart' as transSync;

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
  late final TextEditingController _publicKey;

  @override
  void initState() {
    super.initState();
    _clientID = TextEditingController();
    _secretKey = TextEditingController();
    _publicKey = TextEditingController();
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

  void updatePublicKeyText(String newText) {
    setState(() {
      _publicKey.text = newText;
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
                    onPressed: () async {
                      // probably run some script
                      // public token is returned
                      var _response = await createItem.createItemCall(
                        _clientID.text,
                        _secretKey.text,
                      );
                      updateRawText(_response);
                      updatePublicKeyText(createItem.getPublicToken(_response));
                    },
                    child: Text('Create Item'),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _publicKey,
                    decoration: const InputDecoration(
                      labelText: 'Public key',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      var _response = await transSync.transactionsSync(
                        _publicKey.text,
                        _clientID.text,
                        _secretKey.text,
                        'CAESJTZ6RzhsUHdnaktDNW9QbzVlcThyaXZHWlcxN2ttZXRWM1ZRbVgiCwjhl7zHBhDIq7krKgsI4Ze8xwYQyKu5Kw==',
                        10,
                      );
                        updateRawText(_response);
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
                    child: SingleChildScrollView(child: Text(rawText)),
                  ),
                  SizedBox(height: 8),
                  Text('Bonus Text'),
                  SizedBox(
                    height: 300,
                    child: SingleChildScrollView(child: Text(bonusText)),
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
