import 'dart:convert';
import 'package:http/http.dart' as http;

class addFavResponse {
  final String message;
  addFavResponse(this.message);
}

class addFavService {
  static Future<addFavResponse> login( int user_id,int food_id,String token) async {
    final String user=user_id.toString();
    final String food=food_id.toString();
    var requestBody = {
      'user_id' : user,
      'food_id': food,

    };
    Map<String, String> headers = {
      'Authentication':token,
    };
    try {
      var response = await http.post(
          Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/favorites'),
          body: requestBody,
          headers: headers
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        print("Message : " + message);
        return addFavResponse(message);
      } else {
        var responseBody = json.decode(response.body);
        String message = responseBody['message'];
        return addFavResponse(message);
        // Gagal login, tampilkan pesan error atau lakukan sesuatu yang lain
        print('Failed to login: ${message}');
      }
    } catch (error) {
      // Terjadi kesalahan saat mengirim request, tampilkan pesan error atau lakukan sesuatu yang lain
      print('Error during login: $error');
    }
    // Jika terjadi kesalahan, kembalikan nilai default
    return addFavResponse('');
  }
}
