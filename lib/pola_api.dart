import 'dart:convert';
import 'package:http/http.dart' as http;

class PolaApi {
  static const _base = 'https://www.pola-app.pl/a/v4/get_by_code';
  static const _deviceId = 'pola-editorial';

  final http.Client _client;

  PolaApi({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> getByCode(String code) async {
    final uri = Uri.parse(_base).replace(queryParameters: {
      'code': code,
      'device_id': _deviceId,
    });
    final response = await _client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'HTTP ${response.statusCode}',
        response.body,
      );
    }
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<void> setIngredients(String code, String ingredients) async {
    const apiKey = String.fromEnvironment('POLA_API_KEY');
    final uri = Uri.parse('https://www.pola-app.pl/a/v4/set_ingredients');
    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey', // Assuming Bearer token
      },
      body: jsonEncode({
        'code': code,
        'ingredients': ingredients,
      }),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException(
        'HTTP ${response.statusCode}',
        response.body,
      );
    }
  }
}

class HttpException implements Exception {
  final String message;
  final String body;
  HttpException(this.message, this.body);

  @override
  String toString() => message;
}
