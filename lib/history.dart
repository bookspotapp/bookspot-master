import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage("ASSETS/logo.png"),
        ),
        backgroundColor: HexColor("#f9692d"),
        elevation: 0.0,
      ),
      endDrawer: Container(
        width: 230,
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileSetting()));
                    },
                    child: new Text(
                      "Profile Settings",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "myRoute");
                    },
                    child: new Text(
                      "Upcoming Spot ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Favorites()));
                    },
                    child: new Text(
                      "Favorites            ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => History()));
                    },
                    child: new Text(
                      "History               ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => PrivacyPo()));
                    },
                    child: new Text(
                      "Privacy Policy   ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Setting()));
                    },
                    child: new Text(
                      "Settings             ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "myRoute");
                    },
                    child: new Text(
                      "Log Out             ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 240,
                  ),
                  Text(
                    "Follow                     ",
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          icon: new Image.asset("ASSETS/instagram.png"),
                          onPressed: null),
                      IconButton(
                          icon: new Image.asset("ASSETS/facebook.png"),
                          onPressed: null),
                      IconButton(
                          icon: new Image.asset("ASSETS/twitter.png"),
                          onPressed: null)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Form(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 200),
                    child: Text(
                      "History",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("ASSETS/ticket.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Place name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Category:     ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 65,
                              ),
                              Text(
                                " Date",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              Text(
                                "Time:",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 320,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("ASSETS/ticket.png"),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Place name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Category:     ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 65,
                              ),
                              Text(
                                " Date",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              Text(
                                "Time:",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // child: Image.asset(
                    //   'ASSETS/ticket.png',
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                  Container(
                    height: 150,
                    width: 320,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("ASSETS/ticket.png"),
                            fit: BoxFit.fill)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Place name",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 110),
                            child: Text(
                              "Category:     ",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 65,
                              ),
                              Text(
                                " Date",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 90,
                              ),
                              Text(
                                "Time:",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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
