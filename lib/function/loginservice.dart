import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginResponse {
  final String message;
  final Map<String, dynamic> data;
  final String token;

  LoginResponse(this.message, this.data, this.token);
}

class LoginService {
  static Future<LoginResponse> login(String email, String password) async {
    var requestBody = {
      'email': email,
      'password': password,
    };

    try {
      var response = await http.post(
        Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/users/login'),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        Map<String, dynamic> data = responseBody['data'];
        String token = responseBody['token'];
        print("Message : " + message);
        return LoginResponse(message, data, token);
      } else {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        return LoginResponse(message, {}, '');
        // Gagal login, tampilkan pesan error atau lakukan sesuatu yang lain
        print('Failed to login: ${message}');
      }
    } catch (error) {
      // Terjadi kesalahan saat mengirim request, tampilkan pesan error atau lakukan sesuatu yang lain
      print('Error during login: $error');
    }

    // Jika terjadi kesalahan, kembalikan nilai default
    return LoginResponse('', {}, '');
  }
}
