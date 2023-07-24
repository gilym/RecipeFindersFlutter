import 'package:flutter/material.dart';
import 'package:recipefinders/function/changepassword.dart';
import 'package:recipefinders/main.dart';

import 'dashboard.dart';


class changePassword extends StatefulWidget {
  final int id;
  final String token;
  const changePassword({Key? key,required this.id,required this.token}) : super(key: key);

  @override
  State<changePassword> createState() => _changePasswordState();
}

class _changePasswordState extends State<changePassword> {
  String _inputOldPassword = "";
  String _inputNewPassword = "";
  String _inputConfirmPassword = "";

  bool _obscureText1 = false;
  bool _obscureText2 = false;
  bool _obscureText3 = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Background,
      appBar: (
          AppBar(
            backgroundColor: Background,
            elevation: 0,
            automaticallyImplyLeading: false,
          )
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 50,),
          Center(
            child: Text("Change Password",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,

              ),

            ),
          ),
          SizedBox(height: 50,),
          Container(
            width: MediaQuery.of(context).size.width / 1.04,
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  _inputOldPassword=value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Old Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock,
                  color: Colors.grey,),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText1 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                ),

                // labelStyle: TextStyle(color: fontcollor), // Set label text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!), // Set border color
                  borderRadius: BorderRadius.circular(15.0), // Set border radius
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Darkmode? Colors.white :Colors.deepOrange), // Set focused border color
                  borderRadius: BorderRadius.circular(20.0), // Set border radius
                ),
              ),
              // style: TextStyle(color: fontcollor),
              validator: (value) =>
              value!.isEmpty ? 'Please enter a password' : null,
              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText1,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width / 1.04,
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  _inputNewPassword=value;
                });
              },
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock,
                  color: Colors.grey,),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText2 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),

                // labelStyle: TextStyle(color: fontcollor), // Set label text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!), // Set border color
                  borderRadius: BorderRadius.circular(15.0), // Set border radius
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Darkmode? Colors.white :Colors.deepOrange), // Set focused border color
                  borderRadius: BorderRadius.circular(20.0), // Set border radius
                ),
              ),
              // style: TextStyle(color: fontcollor),
              validator: (value) =>
              value!.isEmpty ? 'Please enter a password' : null,
              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText2,
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width / 1.04,
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  _inputConfirmPassword=value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock,
                  color: Colors.grey,),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText3 ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText3 = !_obscureText3;
                    });
                  },
                ),

                // labelStyle: TextStyle(color: fontcollor), // Set label text color
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[400]!), // Set border color
                  borderRadius: BorderRadius.circular(15.0), // Set border radius
                ),
                focusedBorder: OutlineInputBorder(
                  // borderSide: BorderSide(color: Darkmode? Colors.white :Colors.deepOrange), // Set focused border color
                  borderRadius: BorderRadius.circular(20.0), // Set border radius
                ),
              ),
              // style: TextStyle(color: fontcollor),
              validator: (value) =>
              value!.isEmpty ? 'Please enter a password' : null,
              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText3,
            ),
          ),

          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 45,
            child: ElevatedButton(
              onPressed: () {

                print(_inputConfirmPassword);
                print(_inputOldPassword);
                print(_inputNewPassword);

                if(_inputNewPassword==_inputConfirmPassword){
                  _showConfirmationDialog(_inputOldPassword, _inputNewPassword);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("New Password and Confirm password are different",style: TextStyle(
                        fontSize: 18
                    ),),
                      backgroundColor: button,),
                  );
                }

              },
              child: Text(
                'Confirm',
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
      ),
    );
  }
  Future<void> _editPass(String oldpass , String pass) async {

    String token = widget.token;
    int id = widget.id;


    changePasswordResponse passwordresponse = await changePasswordService.login(oldpass,pass,id,token);
    String message = passwordresponse.message;

    // Lakukan sesuatu dengan nilai message, data, dan token
    // ...

    if (message == 'Password updated successfully') {
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
  Future<void> _showConfirmationDialog(String oldpass, String pass) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Tidak dapat menutup dialog dengan mengetuk di luar dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda ingin merubah Password?'),
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
                _editPass(oldpass, pass);
              },
            ),
          ],
        );
      },
    );
  }
}
