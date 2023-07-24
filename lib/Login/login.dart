import 'package:flutter/material.dart';
import 'package:recipefinders/ForgotPassword/insertemail.dart';
import 'package:recipefinders/Login/register.dart';
import 'package:recipefinders/Main%20menu/dashboard.dart';
import 'package:recipefinders/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../function/loginservice.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  String _inputEmail = "";
  late SharedPreferences _prefs;
  String _inputPassword = "";
  bool _obscureText = false;

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Background,
      appBar: (
      AppBar(
        backgroundColor: Background,
        elevation: 0,
      )
      ),

      body: Column(

        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 20,),
          Center(
            child: Text("Log in to your account",
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
                  _inputEmail=value;
                });
              },

              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email_outlined,
                  color: Colors.grey,),


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

              // onSaved: (value) => _inputPassword = value!,

            ),
          ),
          SizedBox(height: 20,),

          Container(

            width: MediaQuery.of(context).size.width / 1.04,
            child: TextFormField(
              onChanged: (value){
                setState(() {
                  _inputPassword=value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock,
                  color: Colors.grey,),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
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
              validator: (value) =>value!.isEmpty ? 'Please enter a password' : null,


              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width / 1.04,
            alignment: Alignment.topRight,
            child:
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const insertemailpage(),
                  ),
                );
              },
              child: Text("Forgot Password?",

              style: TextStyle(
                color: button
              ),) ,
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 46,
            child: ElevatedButton(
              onPressed: () {
           _login();
              },
              child: Text(
                'Login',
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
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const registerpage(),
                  ),
                );
              },
              child: Text(
                'Register',
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
  Future<void> _login() async {
    String email = _inputEmail;
    String password = _inputPassword;

    LoginResponse loginResponse = await LoginService.login(email, password);
    String message = loginResponse.message;
    Map<String, dynamic> data = loginResponse.data;
    String token = loginResponse.token;

    // Lakukan sesuatu dengan nilai message, data, dan token
    // ...

    if (message == 'Login Successful') {
      _prefs.setString('token', token);
      _prefs.setBool('isLoggedIn', true);
      _prefs.setString('name', data['name']);
      _prefs.setString('email', data['email']);
      _prefs.setInt('id', data['id']);
      _prefs.setString('img', data['img']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  dashboardpage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
          fontSize: 18
        ),),
        backgroundColor: button,),
      );
    }
  }


}
