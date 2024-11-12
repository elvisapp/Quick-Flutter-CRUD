import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'TU-IP:5000';

  static Future<List<dynamic>> getItems() async {
    final response = await http.get(Uri.parse('$apiUrl/items'));
    return jsonDecode(response.body);
  }

  static Future<void> addItem(String name) async {
    await http.post(
      Uri.parse('$apiUrl/items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );
  }
}
