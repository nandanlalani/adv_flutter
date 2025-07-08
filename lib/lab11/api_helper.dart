import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_model.dart';

class ApiService {
  static const String baseUrl = 'https://66ed1eda380821644cdb715a.mockapi.io/Flag';

  static Future<List<FlagModel>> fetchFlags() async {
    final res = await http.get(Uri.parse(baseUrl));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((json) => FlagModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<FlagModel> addFlag(FlagModel flag) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(flag.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode == 201) {
      return FlagModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to add flag');
    }
  }

  static Future<void> updateFlag(String id, FlagModel flag) async {
    await http.put(
      Uri.parse('$baseUrl/$id'),
      body: jsonEncode(flag.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<void> deleteFlag(String id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
