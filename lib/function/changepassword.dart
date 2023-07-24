import 'dart:convert';
import 'package:http/http.dart' as http;

class changePasswordResponse {
  final String message;
  changePasswordResponse(this.message);
}

class changePasswordService {
  static Future<changePasswordResponse> login(String oldpass,String newpass, int id,String token) async {
    var requestBody = {
      'oldpassword' : oldpass,
      'password': newpass,

    };
    Map<String, String> headers = {
      'Authentication':token,
    };
    try {
      var response = await http.put(
          Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/editpass/$id'),
          body: requestBody,
          headers: headers
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        print("Message : " + message);
        return changePasswordResponse(message);
      } else {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        return changePasswordResponse(message);
        // Gagal login, tampilkan pesan error atau lakukan sesuatu yang lain
        print('Failed to login: ${message}');
      }
    } catch (error) {
      // Terjadi kesalahan saat mengirim request, tampilkan pesan error atau lakukan sesuatu yang lain
      print('Error during login: $error');
    }
    // Jika terjadi kesalahan, kembalikan nilai default
    return changePasswordResponse('');
  }
}
