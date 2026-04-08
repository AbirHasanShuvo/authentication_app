
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = 'https://ez-train.vercel.app'});

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final response = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    try {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
    } catch (e) {
      throw Exception('Failed to parse JSON: $e');
    }
  }
}