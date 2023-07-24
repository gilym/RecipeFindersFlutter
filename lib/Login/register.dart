import 'package:flutter/material.dart';
import 'package:recipefinders/function/registerservice.dart';
import 'package:recipefinders/main.dart';

import '../Main menu/dashboard.dart';
import '../function/loginservice.dart';
import 'login.dart';


class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  String _inputEmail = "";
  String _inputName = "";
   String _inputPassword = "";
   String mes ="";
  bool _obscureText = false;
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
          SizedBox(height: MediaQuery.of(context).size.height / 15,),
          Center(
            child: Text("Crrate an Acoount",
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
                  _inputName=value;
                });
              },
              decoration: InputDecoration(
                labelText: 'FullName',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person,
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
              validator: (value) =>
              value!.isEmpty ? 'Please enter a password' : null,
              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText,
            ),
          ),
          SizedBox(height: 20,),
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
              validator: (value) =>
              value!.isEmpty ? 'Please enter a password' : null,
              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText,
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
              validator: (value) =>
              value!.isEmpty ? 'Please enter a password' : null,
              // onSaved: (value) => _inputPassword = value!,
              obscureText: _obscureText,
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                _register();



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

  Future<void> _register() async {
    String name =_inputName;
    String email = _inputEmail;
    String password = _inputPassword;

    registerResponse loginResponse = await RegisterService.login(name,email, password);
    String message = loginResponse.message;

    // Lakukan sesuatu dengan nilai message, data, dan token
    // ...

    if (message == 'User inserted successfully') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message,style: TextStyle(
            fontSize: 18
        ),),
          backgroundColor: button,),
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => loginpage()), (route) => false);



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
