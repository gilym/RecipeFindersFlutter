import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipefinders/Main%20menu/dashboard.dart';

import '../Login/login.dart';
import '../function/changeimageprofile.dart';
import '../function/editprofileservice.dart';
import '../main.dart';
class editprofile extends StatefulWidget {
  final String img ;
  final String name;
  final String email;
  final int id;
  final String token;
  const editprofile({Key? key, required this.name , required this.img, required this.email,required this.id,required this.token}) : super(key: key);

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  String _inputName = "";
  String _inputEmail = "";
  late TextEditingController _textEditingName;
  late TextEditingController _textEditingEmail;

  @override
  void initState() {
    super.initState();
    _textEditingName = TextEditingController(text: widget.name);
    _textEditingEmail = TextEditingController(text: widget.email);
  }

  File? _selectedImage1=null;
  bool cekimage =false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _selectedImage1 = File(pickedImage.path);
        cekimage = true;
      } else {
        print('No image selected.');
        cekimage = false;
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Background,
      appBar: AppBar(
        backgroundColor:button ,
        elevation:0,
        automaticallyImplyLeading: false,
        title: Text("Edit Profile",
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true ,
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Stack(
            children: [
              Container(
                height:200,
                color: Background,
              ),
              Container(
                height:120,
                color: button,
              ),


              Positioned(
                top: MediaQuery.of(context).size.height/17,
                left: 0,
                right: 0,
                child:CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(widget.img),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: MediaQuery.of(context).size.width/3,
                        child: GestureDetector(
                          onTap: () async {
                            await _pickImage(ImageSource.gallery).then((pickedImage) {

                              if(cekimage==true){
                                print(cekimage);
                                _showFotoConfirmationDialog();
                              }
                              else{

                              }


                              // Lakukan tindakan lain dengan gambar yang dipilih
                            });
                          },

                          child: Container(
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(

                              shape: BoxShape.circle,
                              color: Colors.grey[300]?.withOpacity(0.7),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child:
            Text(widget.name,
              style: TextStyle(
                  fontSize: 28
              ),),
          ),

          Column(
            children: [
              SizedBox(height: 25,),
              Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width / 1.08,
                child: TextFormField(
                  controller: _textEditingName,
                  onChanged: (value){
                    setState(() {
                      _inputName=value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelStyle: TextStyle(color: fontcollor), // Set label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Set border color
                      borderRadius: BorderRadius.circular(15.0), // Set border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      // borderSide: BorderSide(color: Darkmode? Colors.white :Colors.deepOrange), // Set focused border color
                      borderRadius: BorderRadius.circular(15.0), // Set border radius
                    ),
                  ),
                  // style: TextStyle(color: fontcollor),
                  validator: (value) =>value!.isEmpty ? 'Please enter a password' : null,


                  // onSaved: (value) => _inputPassword = value!,

                ),
              ),
              SizedBox(height: 25,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                width: MediaQuery.of(context).size.width / 1.08,
                child: TextFormField(
                  controller: _textEditingEmail,
                  onChanged: (value){
                    setState(() {
                      _inputEmail=value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    // labelStyle: TextStyle(color: fontcollor), // Set label text color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Set border color
                      borderRadius: BorderRadius.circular(15.0), // Set border radius
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      // borderSide: BorderSide(color: Darkmode? Colors.white :Colors.deepOrange), // Set focused border color
                      borderRadius: BorderRadius.circular(15.0), // Set border radius
                    ),
                  ),
                  // style: TextStyle(color: fontcollor),
                  validator: (value) =>value!.isEmpty ? 'Please enter a password' : null,


                  // onSaved: (value) => _inputPassword = value!,

                ),
              ),
              SizedBox(height: 25,),
              Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    final initialName = widget.name;
                    final initialEmail = widget.email;

                    final name = _inputName.isNotEmpty ? _inputName : initialName;
                    final email = _inputEmail.isNotEmpty ? _inputEmail : initialEmail;

                    print(name);
                    print(email);
                    print(widget.id);
                     _showConfirmationDialog(name, email);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: button, // Set button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Set the borderRadius
                    ),
                  ),
                ),
              ),
            ],
          )

        ],
      ),
    );
  }
  Future<void> _editProfile(String name , String email) async {

    String token = widget.token;
    int id = widget.id;


    ediprofileResponse profileResponse = await editProfileService.login(name,email,id,token);
    String message = profileResponse.message;

    // Lakukan sesuatu dengan nilai message, data, dan token
    // ...

    if (message == 'Users updated successfully') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => dashboardpage()), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
    }
  }
  Future<void> _showConfirmationDialog(String name, String email) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Tidak dapat menutup dialog dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda ingin merubah profil?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                _editProfile(name, email);
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _editFotoProfile() async {

    String token = widget.token;
    int id = widget.id;


    changeimageResponse imageResponse = await changeimageService.login(id,_selectedImage1!,token);
    String message = imageResponse.message;

    // Lakukan sesuatu dengan nilai message, data, dan token
    // ...

    if (message == 'Users updated successfully') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => dashboardpage()), (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
    }
  }
  Future<void> _showFotoConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Tidak dapat menutup dialog dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda ingin merubah Foto Profile?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
                _editFotoProfile();
              },
            ),
          ],
        );
      },
    );
  }

}
