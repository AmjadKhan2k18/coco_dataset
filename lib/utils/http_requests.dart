import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HttpRequest {
  static late String explorerApiUrl;
  static late String cloudFunctionUrl;

  static init({bool isTest = false}) async {
    if (isTest) {
      dotenv.testLoad(fileInput: File('assets/.env').readAsStringSync());
    } else {
      await dotenv.load(fileName: "assets/.env");
    }

    explorerApiUrl = dotenv.get('COCO_EXPLORER_URL');
    cloudFunctionUrl = dotenv.get('CLOUD_FUNCTION_URL');
  }

  static Future<dynamic> get() async {
    final uri = Uri.parse(explorerApiUrl);
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 404) {
        return null;
      }
    } catch (e) {
      throw Exception('Something went wrong!');
    }
  }

  static Future<String?> post({required Map<String, dynamic> data}) async {
    final uri = Uri.parse(cloudFunctionUrl);
    try {
      final response = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {'content-type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 404) {
        return null;
      }
    } catch (e) {
      throw Exception('Something went wrong! $e');
    }
    return null;
  }
}
