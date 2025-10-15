import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/appstorage.dart' as appstorage;

// this file is just going to return the entire response string, plaid runner can do more with that

Future<String> transactionsSync(
  String publicKey,
  String clientId,
  String secret,
  String cursor,
  int count,
) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse('https://sandbox.plaid.com/transactions/sync'),
  );
  request.body = json.encode({
    "client_id": clientId,
    "secret": secret,
    "access_token": "access-sandbox-9c1257ff-0983-42c7-bc83-05ffc543e3dc",
    "cursor":
        "CAESJTZ6RzhsUHdnaktDNW9QbzVlcThyaXZHWlcxN2ttZXRWM1ZRbVgiCwjhl7zHBhDIq7krKgsI4Ze8xwYQyKu5Kw==",
    "count": 10, // 10 for now is good lets not cloud ourselves here
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    return response.reasonPhrase ?? 'Unkown error';
  }
}


