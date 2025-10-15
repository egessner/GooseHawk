import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/appstorage.dart' as appstorage;

Future<String> createItemCall(String clientID, String secret) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse('https://sandbox.plaid.com/sandbox/public_token/create'),
  );
  request.body = json.encode({
    "client_id": clientID,
    "secret": secret,
    "institution_id": "ins_20",
    "initial_products": ["transactions"],
    "options": {"webhook": "https://www.plaid.com/webhook"},
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    return response.reasonPhrase ?? 'Unkown error';
  }
}

String extractPublicToken(String responseString) {
  try {
    final decoded = json.decode(responseString);
    if (decoded is Map && decoded.containsKey('public_token')) {
      return decoded['public_token'] as String;
    } else {
      return 'No available public token';
    }
  } catch (e) {
    print('Error decoding public token: $e');
    return 'No available public token';
  }
}

Future<bool> fetchAndStorePublicToken() async {
  var clientID = await appstorage.readData(appstorage.DataKey.clientId);
  var secretKey = await appstorage.readData(appstorage.DataKey.secretKey);
  if (clientID == null || secretKey == null) {
    print('Missing one or more required tokens.');
    return false;
  }

  var responseString = await createItemCall(clientID, secretKey);
  var publicToken = extractPublicToken(responseString);

  if (publicToken == 'No available public token') {
    print('Access token not found in response');
    return false; // TODO i think eventually we'll make like an error snackbar class that we can give this to
  }

  await appstorage.saveData(appstorage.DataKey.publicToken, publicToken);
  return true;
}
