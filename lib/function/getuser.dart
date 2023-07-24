

import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:http/http.dart' as http;

class getUser {
  static Future<Map<String, dynamic>> fetchuser(String token,int id) async {
    print(token);
    List<dynamic> user = [];
    try {

      final url = "https://backend-dot-recipe-finder-388213.as.r.appspot.com/users/$id";

      // Tambahkan header authentication di bawah ini
      Map<String, String> headers = {
        'Authentication': token,
      };
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final data = response.body;

        user.addAll(jsonDecode(data) as List<dynamic>);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print(error);
    }


    return user[0];
  }
}

