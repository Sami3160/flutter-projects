import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client _client =http.Client();
  Future<http.Response>   post(
    String url,
    Map<String, dynamic> body,
  ){
    return _client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }
}