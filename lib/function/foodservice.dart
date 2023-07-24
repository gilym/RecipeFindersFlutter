

import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:http/http.dart' as http;

class getFood {
  static Future<List<dynamic>> fetchfood(String token) async {
    print(token);
    List<dynamic> food = [];
    try {

      final url = "https://backend-dot-recipe-finder-388213.as.r.appspot.com/food";

      // Tambahkan header authentication di bawah ini
      Map<String, String> headers = {
        'Authentication': token,
      };
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = response.body;

        food.addAll(jsonDecode(data) as List<dynamic>);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }
print("token " + token);

    return food;
  }
}

