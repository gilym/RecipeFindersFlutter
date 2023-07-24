import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class changeimageResponse {
  final String message;
  changeimageResponse(this.message);
}

class changeimageService {
  static Future<changeimageResponse> login(int id, File image,String token) async {
    if (image != null) {
      print("hadir");
      final url = Uri.parse('https://backend-dot-recipe-finder-388213.as.r.appspot.com/editimage/$id');
      final request = http.MultipartRequest('PUT', url);
      request.files.add(await http.MultipartFile.fromPath('img', image.path));
      request.headers['Authentication'] = token;

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          print("berhasil proses image");

          final responseString = await response.stream.bytesToString();
          final jsonResponse = jsonDecode(responseString);
          return changeimageResponse(jsonResponse['message']);




        } else {
          print('Failed to send image. Error: ${response.reasonPhrase}');
          return changeimageResponse('${response.reasonPhrase}');
        }
      } catch (error) {
        print('Error sending image: $error');
      }
      catch (error) {
        print('Failed to send image. Error: $error');
      }
    }
    else {
      print('No image selected.');
    }
    // Jika terjadi kesalahan, kembalikan nilai default
    return changeimageResponse('');
  }
}
