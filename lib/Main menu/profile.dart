import 'dart:ffi';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipefinders/Login/login.dart';
import 'package:recipefinders/Main%20menu/changepassword.dart';
import 'package:recipefinders/Main%20menu/editprofile.dart';
import 'package:recipefinders/Main%20menu/favoritelist.dart';
import 'package:recipefinders/function/changeimageprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'dashboard.dart';
class profilepage extends StatefulWidget {
  final String img ;
  final String name;
  final String email;
  final int id;
  final List<dynamic> Favorite;
  final String token;
  const profilepage({Key? key, required this.name , required this.img, required this.Favorite,required this.email, required this.id,required this.token}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  late SharedPreferences _prefs;
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
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background,
     body: ListView(
       padding: EdgeInsets.only(top: 0),
       children: [
         Stack(
           children: [
             Container(
               height:280,
               color: Background,
             ),
             Container(
               height:200,
               color: button,
             ),
             Positioned(
               top: MediaQuery.of(context).size.height/7,
               left: 0,
               right: 0,
               child:CircleAvatar(
                 radius: 70,
                 backgroundColor: Colors.transparent,
                 child: Container(
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

           GestureDetector(
             onTap:(){
               Navigator.push(
                         context,
                         MaterialPageRoute(
                           builder: (context) =>  editprofile(name: widget.name, img: widget.img , email: widget.email,id: widget.id,token: widget.token,),
                         ),
                       );

             },
             child:  list("Edit Profile", Icons.edit)
             ,
           ),
           GestureDetector(
             child: list("Favorite", Icons.favorite),
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => favoriteList(Favorite: widget.Favorite,),
                 ),
               );
             },
           ),



           GestureDetector(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) =>  changePassword(id: widget.id,token: widget.token,),
                 ),
               );
             },
             child:
             list("Change Password", Icons.password),
           ),

           GestureDetector(
             onTap: (){
               _prefs.setBool('isLoggedIn', false);
               _prefs.remove('name');
               _prefs.remove('token');
               _prefs.remove('id');
               _prefs.remove('img');

               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginpage()), (route) => false);

             },
             child: list("Logout", Icons.login_outlined),
           )
         ],
       )

       ],
     ),
    );
  }
  Widget list (String title , IconData icons){
    return  Container(
      margin: EdgeInsets.only(top: 20,bottom:20
      ),
      width: MediaQuery.of(context).size.width / 1.1,
      padding:EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Background,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // arah bayangan
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icons),
          SizedBox(width: 14,),
          Text(title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),
        ],
      ),
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
