import 'dart:convert';
import 'package:http/http.dart' as http;

class RagicApi {
  static const String apiKey = 'QmpBTExHdUx6dTg3YVBOeDQvQ2VTUWtOWmI0ckdIbVRNVWY4OFVkWjYrRUVUTzZsK0xKbyszT0hUYlBOQ2xPODlYVWdsR0pQeitjPQ==';
  static const String apiUrl = 'https://www.ragic.com/quanlac/employee/6/?v=3&APIKey=${apiKey}&api';

  static Future<http.Response> createRecord(Map<String, String> data) async {
    http.Response res = await http.post(
      Uri.parse('$apiUrl'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$apiKey:')),
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
    print(res.body);

    return res;
  }

  static Future<http.Response> readRecords() async {
    http.Response res = await http.get(
      Uri.parse('$apiUrl'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$apiKey:')),
      },
    );

    print(res.body);
    return res;
  }

  static Future<http.Response> updateRecord(String id, Map<String, String> data) {
    return http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$apiKey:')),
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );
  }
}
