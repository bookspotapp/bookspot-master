import 'package:bookspot/firstpage.dart';
import 'package:bookspot/forget.dart';
import 'package:bookspot/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Otp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String number = "";
String name = "";

class _LoginPageState extends State<LoginPage> {

  TextEditingController noCoontroller = new TextEditingController();
  TextEditingController nameController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage("ASSETS/logo.png"),
        ),
        backgroundColor: HexColor("#f9692d"),
      ),

      body: Form(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 210),
                    child: Text(
                      "Login",
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
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.account_circle),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    controller: nameController,
                    onSaved: (String val) {
                      number = val;
                    },
                      autovalidate: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      }
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
                      hintText: 'Phone number',
                      prefixIcon: Icon(Icons.phone),
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    controller: noCoontroller,
                    onSaved: (String val) {
                      number = val;
                    },
                      autovalidate: true,
                      validator: (value) {
                        if (value.isEmpty || value.length != 10) {
                          return 'Enter valid Phone No.';
                        }
                        return null;
                      }
                  ),


                  SizedBox(
                    height: 150,
                  ),
                  MaterialButton(
                    height: 52,
                    minWidth: 323,
                    color: HexColor("#f9692d"),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      "Send OTP",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      number = "+91" + noCoontroller.text.trim();
                      name = nameController.text.trim();
                      if(name.isNotEmpty && number.isNotEmpty && number.length == 10)
                      Firebase.initializeApp();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => OTpSc()));
                    },
                    splashColor: Colors.redAccent,
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
