import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/restaurant/restocancle.dart';
import 'package:bookspot/restaurant/restservices.dart';
import 'package:bookspot/salon/Cancel.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ConfiramationRest extends StatefulWidget {
  @override
  _ConfiramationRestState createState() => _ConfiramationRestState();
}

class _ConfiramationRestState extends State<ConfiramationRest> {
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
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    right: 140,
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                    ),
                    iconSize: 40,
                    color: Colors.black,
                    splashColor: Colors.purple,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
                    "Profile Settings",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
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
                        fontSize: 25,
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
                        fontSize: 25,
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
                    "History               ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
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
                        fontSize: 25,
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
                        fontSize: 25,
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
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Form(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        iconSize: 30,
                        color: Colors.black,
                        splashColor: Colors.purple,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestServices()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 170),
                      child: Text(
                        "Confirmation",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, // set border color
                            width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text("Restaurant Name:"),
                              SizedBox(
                                width: 100,
                              ),
                              Text("A B C D"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text("Table for:"),
                              SizedBox(
                                width: 160,
                              ),
                              Text("04"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text("Date:"),
                              SizedBox(
                                width: 150,
                              ),
                              Text("02/ 09/ 20"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text("Timings:"),
                              SizedBox(
                                width: 150,
                              ),
                              Text("09 : 00 AM"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Text("Expected Waiting Time:"),
                        SizedBox(
                          width: 10,
                        ),
                        Text("00 : 02 :59")
                      ],
                    ),
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
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CancleeRest()));
                      },
                      splashColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
