import 'dart:async';

import 'package:bookspot/loginpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bookspot/Introduction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContainerClass.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

Customer customer = new Customer();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookspot',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    Timer(
        Duration(seconds: 2),
        forwardTo);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: HexColor("#f96021"),
        child: Center(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        "ASSETS/logo.png",
                      ),
                      width: 120,
                      height: 120,
                    ),

                    Text(
                      "BookSpot",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                      ),
                    )
                  ],
                )
        )
    );
  }

  void forwardTo() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getBool("second") == null){
      print("null");
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Introduction()
      ));
    }else{
      if(preferences.getBool("logged") == null) {
        print("null ");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print("not null");
        bool login = preferences.getBool("logged");
        if(login){
          customer.nm = preferences.getString("name");
          customer.uid = preferences.getString("uid");
          customer.cno = preferences.getString("cno");
          customer.email = preferences.getString("email");

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => HomePage(customer)));
        }else{

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage()));
        }
      }
    }
  }
}
