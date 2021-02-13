import 'package:bookspot/favorites.dart';
import 'package:bookspot/history.dart';
import 'package:bookspot/loginpage.dart';
import 'package:bookspot/notification.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/salon/SearchSpot.dart';
import 'package:bookspot/salon/first.dart';
import 'package:bookspot/salon/upcoming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'ContainerClass.dart';

class HomePage extends StatefulWidget {
  Customer customer;

  HomePage(this.customer);
  @override
  _HomePageState createState() => _HomePageState(customer);
}

class _HomePageState extends State<HomePage> {
  List<bool> isButtonPressed = [false,false,false,false,false,false,false,false,false];
  Customer customer;
  String favList = "";

  _HomePageState(this.customer);

  @override
  void initState() {
    // TODO: implement initState
    getFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return new WillPopScope(
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Image(
                image: AssetImage("ASSETS/logo.png"),
              ),
              backgroundColor: HexColor("#f9692d"),
              elevation: 0.0,
            ),


            endDrawer: Container(
              width: width*0.7,
              child: Drawer(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        children: [
                          SizedBox(width: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Image(
                              image: AssetImage(
                                "ASSETS/cross.png",
                              ),
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileSetting(customer)));
                            },
                            child: new Text(
                              "Profile Settings",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Upcoming(customer)));
                            },
                            child: new Text(
                              "Upcoming Spot ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Favorites(customer)));
                            },
                            child: new Text(
                              "Favourites            ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => History(customer)));
                            },
                            child: new Text(
                              "History               ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => NotiFication(customer)));
                            },
                            child: new Text(
                              "Notification   ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),




                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              logout();
                            },
                            child: new Text(
                              "Log Out             ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),


                      SizedBox(
                        height: 240,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Follow                     ",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),


                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                          ),
                          IconButton(
                            icon: new Image.asset("ASSETS/instagram.png"),
                            onPressed: () => _launchURL("https://www.instagram.com/bookspot.app/"),
                          ),
                          IconButton(
                            icon: new Image.asset("ASSETS/facebook.png"),
                            onPressed: () => _launchURL("https://www.facebook.com/bookspotapp/"),
                          ),
                          IconButton(
                            icon: new Image.asset("ASSETS/twitter.png"),
                            onPressed: () => _launchURL("https://twitter.com/bookspotapp/"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),


            body: Form(
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "Hello, ${customer.nm} ",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
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
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => SearchSpot(customer, favList, null)
                          ));
                        },
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Categories",
                        style: TextStyle(color: Colors.orange),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Salons.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(()  {
                                          isButtonPressed[0] =
                                          !isButtonPressed[0];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Salon", customer,
                                                          favList, null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Salons"),
                              ],
                            ),
                          ),


                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Restaurants.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(()  {
                                          isButtonPressed[1] =
                                          !isButtonPressed[1];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Restaurant", customer,
                                                          favList, null)));

                                        });

                                    }),

                                SizedBox(height: 10,),
                                Text("Restaurants"),
                              ],
                            ),
                          ),


                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(5.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Doctors.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[2] =
                                          !isButtonPressed[2];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Doctor", customer,
                                                          favList, null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Doctors"),
                              ],
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Diagnostic Centres.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[3] =
                                          !isButtonPressed[3];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Diagnostic Centre",
                                                          customer, favList,
                                                          null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Diagnostic\nCentres",textAlign: TextAlign.center,),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Service Centres.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[4] =
                                          !isButtonPressed[4];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Service Centre",
                                                          customer, favList,
                                                          null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Service\nCentres", textAlign: TextAlign.center,),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Gyms.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[5] =
                                          !isButtonPressed[5];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Gyms & Turf", customer,
                                                          favList, null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Gyms & Turfs"),
                              ],
                            ),
                          ),

                        ],
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Banks.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[6] =
                                          !isButtonPressed[6];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Bank", customer,
                                                          favList, null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Banks"),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 120,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Retails.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[7] =
                                          !isButtonPressed[7];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Retail", customer,
                                                          favList, null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Retails"),
                              ],
                            ),
                          ),


                          SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 130,
                            width: 80,

                            child: Column(
                              children: [
                                FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Image(
                                        image: AssetImage(
                                          'ASSETS/Government Offices.png',
                                        ),
                                        fit: BoxFit.cover),
                                    splashColor: Colors.orange[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() async {
                                          isButtonPressed[8] =
                                          !isButtonPressed[8];
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SalonFirst(
                                                          "Government Office",
                                                          customer, favList,
                                                          null)));

                                      });

                                    }),

                                SizedBox(height: 10,),
                                Text("Government\nOffices", textAlign: TextAlign.center,),
                              ],
                            ),
                          ),



                        ],
                      ),

                      SizedBox(height: 30,),

                      Text(
                        "More Categories are Coming Soon...",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),


        onWillPop: ()async{
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder:  (BuildContext context){
              return AlertDialog(
                title : Container(
                  padding: EdgeInsets.all(5),
                  child: Text("Are you sure you want to exit?", style: TextStyle(color: Colors.black, fontSize: 15.0),),
                ),

                content:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
                        child: Text("Yes", style: TextStyle(color: Colors.orange),),
                      ),
                      SizedBox(width: 50),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                          },
                        child: Text("No", style: TextStyle(color: Colors.orange),),
                      ),
                    ],
                  )
              );
            }
          );
        }
    );
  }

  void _launchURL(String url) async {
    if(await canLaunch(url)){
      bool launched = await launch(
        url,
        forceWebView: false,
        universalLinksOnly: true,
      );

      print("launched = $launched");

      if(!launched){
        await launch(
          url,
          forceWebView: true,
        );
      }
    }
  }

  void getFav() async {
    Firebase.initializeApp();
    print("name = ${customer.nm}");
    print("uid = ${customer.uid}");
    print("cno = ${customer.cno}");

    DataSnapshot ds = await FirebaseDatabase.instance.reference().child("customers/${customer.uid}/fav").once();
    favList = ds.value;
    print("favList = $favList");

  }

  void logout() async{
    FirebaseAuth.instance.signOut();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    sharedPreferences.setBool("logged", false);

  }
}
