import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class JsonReader {
  static Future<T?> readJsonFile<T>(String fileName) async {
    debugPrint('Opening JSON file: $fileName');
    try {
      //TODO: Replace file read method to use DefaultAssetBundle.of(context).loadString('assets/response.json')
      // Get the current script's directory
      String currentDirectory =
          "/Users/savan/Documents/FlutterProjects/KhetiConnect/lib/data/api/mock_response";

      // Construct the full path to the JSON file
      String filePath = '$currentDirectory/$fileName.json';

      // Read the file
      String jsonString = await File(filePath).readAsString();

      // Parse the JSON string
      T jsonData = jsonDecode(jsonString);

      debugPrint('JSON file: $jsonData');
      await Future.delayed(const Duration(milliseconds: 400));
      return jsonData;
    } catch (e) {
      debugPrint('Error reading JSON file: $e');
      return null;
    }
  }
}
