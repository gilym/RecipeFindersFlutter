import 'dart:convert';
import 'package:http/http.dart' as http;

class deleteFavResponse {
  final String message;
  deleteFavResponse(this.message);
}

class deleteFavService {
  static Future<deleteFavResponse> login( int id,String token) async {

    Map<String, String> headers = {
      'Authentication':token,
    };
    try {
      var response = await http.delete(
          Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/favorites/$id'),
          headers: headers
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        print("Message : " + message);
        return deleteFavResponse(message);
      } else {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        return deleteFavResponse(message);
        // Gagal login, tampilkan pesan error atau lakukan sesuatu yang lain
        print('Failed to login: ${message}');
      }
    } catch (error) {
      // Terjadi kesalahan saat mengirim request, tampilkan pesan error atau lakukan sesuatu yang lain
      print('Error during login: $error');
    }
    // Jika terjadi kesalahan, kembalikan nilai default
    return deleteFavResponse('');
  }
}
