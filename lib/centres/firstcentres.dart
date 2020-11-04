import 'package:bookspot/centres/centresservice.dart';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/homepage.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CentreFirst extends StatefulWidget {
  @override
  _CentreFirstState createState() => _CentreFirstState();
}

class _CentreFirstState extends State<CentreFirst> {
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
          children: [
            SingleChildScrollView(
              child: Padding(
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
                                    builder: (context) => HomePage()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 150),
                        child: Text(
                          "Service Centres",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
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
                          hintText: 'Search a Spot',
                          prefixIcon: Icon(Icons.search),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                        onTap: () {
                          // showSearch(context: context, delegate: DataSearch());
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 200),
                        child: Text(
                          "Nearby Centres",
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 70.0,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ServicesCetres()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.black, // set border color
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Center(child: Text("Lorem")),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.black, // set border color
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Center(child: Text("Lorem")),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.black, // set border color
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Center(child: Text("Lorem")),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.black, // set border color
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Center(child: Text("Lorem")),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.black, // set border color
                                          width: 2.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              10.0) //                 <--- border radius here
                                          ),
                                    ),
                                    child: Center(child: Text("Lorem")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Choose From Favorites"),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Choose From Our Patrners"),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 330,
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
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 3),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors
                                                .black, // set border color
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                24.0) //                 <--- border radius here
                                            ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("Duis ut sapien eu urna laoreet"),
                                      Text("maximus. DonecnibhdiLoremIspum"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 330,
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
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 3),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors
                                                .black, // set border color
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                24.0) //                 <--- border radius here
                                            ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("Duis ut sapien eu urna laoreet"),
                                      Text("maximus. DonecnibhdiLoremIspum"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 330,
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
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 3),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors
                                                .black, // set border color
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                24.0) //                 <--- border radius here
                                            ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("Duis ut sapien eu urna laoreet"),
                                      Text("maximus. DonecnibhdiLoremIspum"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 60,
                          width: 330,
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
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 3),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors
                                                .black, // set border color
                                            width: 2.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                24.0) //                 <--- border radius here
                                            ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text("Duis ut sapien eu urna laoreet"),
                                      Text("maximus. DonecnibhdiLoremIspum"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
