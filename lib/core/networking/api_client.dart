import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  Future<http.Response> request({
    required String path,
    Map<String, dynamic> data = const {},
    String type = 'get',
  }) async {
    final response = type == 'get'
        ? await http.get(Uri.parse(path))
        : await http.post(
            Uri.parse(path),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(data),
          );

    return response;
  }
}
