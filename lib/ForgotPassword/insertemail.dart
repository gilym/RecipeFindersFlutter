import 'package:flutter/material.dart';
import 'package:recipefinders/ForgotPassword/insertpassword.dart';
import 'package:recipefinders/main.dart';


class insertemailpage extends StatefulWidget {
  const insertemailpage({Key? key}) : super(key: key);

  @override
  State<insertemailpage> createState() => _insertemailpageState();
}

class _insertemailpageState extends State<insertemailpage> {

  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
          SizedBox(height: MediaQuery.of(context).size.height / 25,),
          Center(
            child: Container(
              child: Column(
                children: [
                  Text("Forgot Password",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  Container(
                    width : MediaQuery.of(context).size.width / 1.1,
                    child: Text("Enter your email to reset your password."
                        "Make sure you use a verified or valid email.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),textAlign: TextAlign.center,),
                  )
                ],
              ),
            ),
          ),

          SizedBox(height: 40,),
          Container(
            width: MediaQuery.of(context).size.width / 1.04,
            child: TextFormField(
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
          SizedBox(height: 30),

          Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const insertpasswordpage(),
                  ),
                );


              },
              child: Text(
                'Send',
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
}
