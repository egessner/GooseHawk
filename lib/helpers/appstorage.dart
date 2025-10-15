import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

enum DataKey { clientId, secretKey, publicToken, accessToken }

Future<File> _getLocalFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return File('${directory.path}/data.json');
}

/// Save or update a specific key-value pair
Future<void> saveData(DataKey savedDataKey, String dataToSave) async {
  final file = await _getLocalFile();
  Map<String, dynamic> data = {};

  // Load existing data if the file exists
  if (await file.exists()) {
    final contents = await file.readAsString();
    if (contents.isNotEmpty) {
      data = json.decode(contents);
    }
  }

  // Update or add new data
  data[savedDataKey.name] = dataToSave;

  await file.writeAsString(json.encode(data));
}

/// Read a single key from the JSON file
Future<String?> readData(DataKey savedDataKey) async {
  try {
    final file = await _getLocalFile();

    if (!await file.exists()) return null;

    final contents = await file.readAsString();
    if (contents.isEmpty) return null;

    final data = json.decode(contents);
    return data[savedDataKey.name];
  } catch (e) {
    print('Error reading file: $e');
    return null;
  }
}

Future<Map<DataKey, String?>> readMultiData(List<DataKey> keys) async {
  final file = await _getLocalFile();
  if (!await file.exists()) return {};

  final contents = await file.readAsString();
  if (contents.isEmpty) return {};

  final data = json.decode(contents);
  final result = <DataKey, String?>{};

  for (final key in keys) {
    result[key] = data[key.name];
  }

  return result;
}

/// Delete a specific key from the JSON file
Future<void> deleteData(DataKey keyToDelete) async {
  try {
    final file = await _getLocalFile();

    // If no file exists, nothing to delete
    if (!await file.exists()) return;

    final contents = await file.readAsString();
    if (contents.isEmpty) return;

    final data = json.decode(contents);

    // Remove the key if it exists
    if (data.containsKey(keyToDelete.name)) {
      data.remove(keyToDelete.name);
      await file.writeAsString(json.encode(data));
    }
  } catch (e) {
    print('Error deleting key from file: $e');
  }
}
