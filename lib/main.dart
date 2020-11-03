import 'dart:async';

import 'package:bookspot/firstpage.dart';
import 'package:bookspot/loginpage.dart';
import 'package:bookspot/splash.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
    Timer(
        Duration(seconds: 2),
        forwardTo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      BgImage(),
    ]));
  }

  void forwardTo() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
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

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage()));
      }else{

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }
}
