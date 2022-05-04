import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  static Future<dynamic> get({required String url}) async {
    final uri = Uri.parse(url);
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

  static Future<dynamic> post({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    final uri = Uri.parse(url);
    try {
      final response = await http.post(uri, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 404) {
        return null;
      }
    } catch (e) {
      throw Exception('Something went wrong!');
    }
  }
}
