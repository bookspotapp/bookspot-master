import 'package:bookspot/Otp.dart';
import 'package:bookspot/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String _name, _number, _password;
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage("ASSETS/logo.png"),
        ),
        backgroundColor: HexColor("#f9692d"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0, top: 12),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ))),
        ],
        elevation: 0.0,
      ),
      body: Form(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 210),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    onSaved: (String val) {
                      _name = val;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    controller: phoneController,
                    keyboardType: TextInputType.text,
                    onSaved: (String val) {
                      _number = val;
                    },
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextFormField(
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //   ),
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     hintText: 'Password',
                  //     prefixIcon: Icon(Icons.lock),
                  //     contentPadding: const EdgeInsets.only(
                  //         left: 14.0, bottom: 8.0, top: 8.0),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(25.0),
                  //       ),
                  //     ),
                  //   ),
                  //   obscureText: true,
                  //   keyboardType: TextInputType.text,
                  //   onSaved: (String val) {
                  //     _password = val;
                  //   },
                  // ),
                  SizedBox(
                    height: 200,
                  ),
                  MaterialButton(
                    height: 52,
                    minWidth: 323,
                    color: Colors.blue[900],
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      "Sent OTP",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => OTpSc()));
                    },
                    splashColor: Colors.redAccent,
                  ),
                  FlatButton(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have account?',
                        style: TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Go here',
                              style: TextStyle(color: Colors.orange)),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
