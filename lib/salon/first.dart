import 'dart:convert';
import 'dart:typed_data';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/homepage.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/service.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io' as Io;
import '../ContainerClass.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart';

class SalonFirst extends StatefulWidget {
  @override
  _SalonFirstState createState() => _SalonFirstState();
}

class _SalonFirstState extends State<SalonFirst> {

  List<Shop> sList = [];
  List<Shop> favList = [];
  String fav = "";
  Position _currentPosition;
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    // TODO: implement initState
    initializeLists();
    _getCurrentLocation();
    super.initState();
  }

  DatabaseReference ref = FirebaseDatabase.instance.reference().child("det/vendors");

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
                        padding: const EdgeInsets.only(right: 250),
                        child: Text(
                          "Salons",
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
                        padding: const EdgeInsets.only(right: 230),
                        child: Text(
                          "Nearby Salons",
                          style: TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                      ),



                      SizedBox(
                        height: 10,
                      ),
                      Text("Choose From Favorites"),

                      SizedBox(
                        height: 20,
                      ),
                      
                      SizedBox(
                          height: 10,
                        ),
                      Text("Choose From Our Patrners"),


                      SizedBox(
                          height: 20,
                        ),

                      FutureBuilder(
                        future: ref.once(),
                        builder: (context, AsyncSnapshot<DataSnapshot> snapshot){
                          if(snapshot.hasData){
                            sList.clear();
                            Map<String, dynamic> values = new Map<String, dynamic>.from(snapshot.data.value);

                            values.forEach((key, val) {
                              Map <String, dynamic> m = new Map<String, dynamic>.from(val);
                              Shop shop = new Shop(
                                  m["uid"],
                                  m["nm"],
                                  m["lat"],
                                  m["lng"]
                              );

                              sList.add(shop);
                            });

                            return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: sList.length,
                                itemBuilder: (context, index){
                                  final item1 = sList[index];
                                  return  Container(
                                      child :Card( //////              <-- Card widget
                                              child: ListTile(
                                                contentPadding: const EdgeInsets.all(10.0),

                                                leading : FutureBuilder(
                                                  future: FirebaseStorage.instance.ref().child("vendors/${item1.uid}/logo.jpg").getDownloadURL(),
                                                  builder: (context, abc){
                                                    if(abc.hasData) {
                                                      print("add = vendors/${item1.uid}/logo.jpg");
                                                      print("url = ${abc.data}");
                                                      String url = abc.data;

                                                      String distance_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&";
                                                      distance_url += "origin=${_currentPosition.latitude},${_currentPosition.longitude}";
                                                      distance_url += "&destinations=${item1.lat},${item1.lng}";
                                                      distance_url += "&key=AIzaSyD7WpJP8mLh6RsvUDPZj4bzsRSeE9roYXc";

                                                      print("distance url = $distance_url");

                                                      return ClipRRect(
                                                        borderRadius: BorderRadius.circular(250),
                                                        child: Image.network(url),
                                                      );
                                                    }
                                                    return CircularProgressIndicator();
                                                  },
                                                ),

                                                title: Text(item1.name),

                                                subtitle: FutureBuilder(
                                                  future: Dio().get("https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origin=${_currentPosition.latitude},${_currentPosition.longitude}&destinations=${item1.lat},${item1.lng}&key=AIzaSyD7WpJP8mLh6RsvUDPZj4bzsRSeE9roYXc"),
                                                  builder: (context, xyz){
                                                    if(xyz.hasData) {
                                                      Response response = xyz.data;
                                                      String dist = response.data + " away";
                                                      return Text(dist);
                                                    }
                                                    return Text("");
                                                  },
                                                ),
                                              ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                          side: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),

                                  )
                                  );
                                }
                            );
                          }
                            return CircularProgressIndicator();

                        },
                      )

                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  Image decodeImageFromBase64(String img64){
    Uint8List bytes = base64Decode(img64);
    return Image.memory(bytes,);
  }

  void initializeLists() async {
    await Firebase.initializeApp();
  }

  _getCurrentLocation() async{

    print("get location called");
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("lat = ${_currentPosition.latitude} lng = ${_currentPosition.longitude}");
      });
    }).catchError((e) {
      print(e);
    });
  }
}
