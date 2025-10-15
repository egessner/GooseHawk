import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/appstorage.dart' as appstorage;

Future<String> getAccessToken(
  String publicToken,
  String clientId,
  String secret,
) async {
  var headers = {'Content-Type': 'application/json'};
  var request = http.Request(
    'POST',
    Uri.parse('https://sandbox.plaid.com/item/public_token/exchange'),
  );
  request.body = json.encode({
    "client_id": clientId,
    "secret": secret,
    "public_token": publicToken,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    return await response.stream.bytesToString();
  } else {
    return response.reasonPhrase ?? 'Unknown Error';
  }
}

String extractAccessToken(String responseString) {
  try {
    final decoded = json.decode(responseString);
    if (decoded is Map && decoded.containsKey('access_token')) {
      return decoded['access_token'] as String;
    } else {
      return 'No available access token';
    }
  } catch (e) {
    print('Error decoding access token: $e');
    return 'No available access token';
  }
}

Future<bool> fetchAndStoreAccessToken() async {
  // get public key, clientid, and secret
  var publicToken = await appstorage.readData(appstorage.DataKey.publicToken);
  var clientID = await appstorage.readData(appstorage.DataKey.clientId);
  var secretKey = await appstorage.readData(appstorage.DataKey.secretKey);

  if (publicToken == null || clientID == null || secretKey == null) {
    print('Missing one or more required tokens.');
    return false;
  }

  var responseString = await getAccessToken(publicToken, clientID, secretKey);
  var accessToken = extractAccessToken(responseString);

  if (accessToken == 'No available access token') {
    print('Access token not found in response.');
    return false;
  }

  await appstorage.saveData(appstorage.DataKey.accessToken, accessToken);
  return true;
}
