import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipefinders/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'detail.dart';

class CameraPage extends StatefulWidget {
  final int id;
  final String token;
  final List<dynamic> Fav;
  const CameraPage({Key? key, required this.id,required this.token,required this.Fav}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
      body: Column(

        children: [
          SizedBox(height: 120,),

          Text(
            'Find your food',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 100,),
          Container(
            child: _selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                height: 300,
              ),
            )
                : Center(
              child: Text(
                'No image selected.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(height: 100,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: Icon(Icons.camera_alt),
                label: Text('Camera'),
                style: ElevatedButton.styleFrom(
                  primary: button,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(Icons.photo_library),
                label: Text('Gallery'),
                style: ElevatedButton.styleFrom(
                  primary: button,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_selectedImage != null) {
                _sendImage();
              } else {
                print('No image selected.');
              }
            },
            child: Text('Send Image'),
            style: ElevatedButton.styleFrom(
              primary: button,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
            ),
          ),
        ],
      ),
    );

  }
  Future<void> _sendImage() async {
    if (_selectedImage != null) {
      final url = Uri.parse('https://pred-dot-recipe-finder-388213.as.r.appspot.com/predict');
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          print("berhasil proses image");

          final responseString = await response.stream.bytesToString();
          final jsonResponse = jsonDecode(responseString);

          if (jsonResponse is Map<String, dynamic>) {
            final Map<String,dynamic> data = jsonResponse;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  detailpage(data: data,id: widget.id,token: widget.token,Fav: widget.Fav,),
              ),
            );
          } else {
            print('Invalid response format.');
          }
        } else {
          print('Failed to send image. Error: ${response.reasonPhrase}');
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
  }
}
