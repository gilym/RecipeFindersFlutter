import 'package:flutter/material.dart';
import 'package:recipefinders/main.dart';


class insertpasswordpage extends StatefulWidget {
  const insertpasswordpage({Key? key}) : super(key: key);

  @override
  State<insertpasswordpage> createState() => _insertpasswordpageState();
}

class _insertpasswordpageState extends State<insertpasswordpage> {

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
              decoration: InputDecoration(
                labelText: 'New Password',
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
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width / 1.04,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
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
}
