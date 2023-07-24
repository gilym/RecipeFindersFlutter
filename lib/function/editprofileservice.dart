import 'dart:convert';
import 'package:http/http.dart' as http;

class ediprofileResponse {
  final String message;
  ediprofileResponse(this.message);
}

class editProfileService {
  static Future<ediprofileResponse> login(String name,String email, int id,String token) async {
    var requestBody = {
      'name' : name,
      'email': email,

    };
    Map<String, String> headers = {
      'Authentication':token,
    };
    try {
      var response = await http.put(
        Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/users/$id'),
        body: requestBody,
        headers: headers
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        print("Message : " + message);
        return ediprofileResponse(message);
      } else {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        return ediprofileResponse(message);
        // Gagal login, tampilkan pesan error atau lakukan sesuatu yang lain
        print('Failed to login: ${message}');
      }
    } catch (error) {
      // Terjadi kesalahan saat mengirim request, tampilkan pesan error atau lakukan sesuatu yang lain
      print('Error during login: $error');
    }
    // Jika terjadi kesalahan, kembalikan nilai default
    return ediprofileResponse('');
  }
}
