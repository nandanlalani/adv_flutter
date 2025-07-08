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
}
