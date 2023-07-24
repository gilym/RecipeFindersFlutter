import 'dart:convert';
import 'package:http/http.dart' as http;

class registerResponse {
  final String message;
  registerResponse(this.message);
}

class RegisterService {
  static Future<registerResponse> login(String name,String email, String password) async {
    var requestBody = {
      'name' : name,
      'email': email,
      'password': password,
    };
    try {
      var response = await http.post(
        Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/users/register'),
        body: requestBody,
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        print("Message : " + message);
        return registerResponse(message);
      } else {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        return registerResponse(message);
        // Gagal login, tampilkan pesan error atau lakukan sesuatu yang lain
        print('Failed to login: ${message}');
      }
    } catch (error) {
      // Terjadi kesalahan saat mengirim request, tampilkan pesan error atau lakukan sesuatu yang lain
      print('Error during login: $error');
    }
    // Jika terjadi kesalahan, kembalikan nilai default
    return registerResponse('');
  }
}
