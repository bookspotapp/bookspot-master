import 'package:bookspot/centres/firstcentres.dart';
import 'package:bookspot/clinic/firstclinic.dart';
import 'package:bookspot/diagnostic/firstdiag.dart';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/history.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/restaurant/firstres.dart';
import 'package:bookspot/salon/first.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isButtonPressed = false;
  bool isButtonPressed1 = false;
  bool isButtonPressed2 = false;
  bool isButtonPressed3 = false;
  bool isButtonPressed4 = false;
  bool isButtonPressed5 = false;

  String name = customer.nm;

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
        width: 250,
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
                        onPressed: () => _launchURL(context),
                      ),
                      IconButton(
                        icon: new Image.asset("ASSETS/facebook.png"),
                        onPressed: () => _launchURL1(context),
                      ),
                      IconButton(
                        icon: new Image.asset("ASSETS/twitter.png"),
                        onPressed: () => _launchURL2(context),
                      )
                    ],
                  )
                ],
              ),
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
                    "Hello, $name ",
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
                    // showSearch(context: context, delegate: DataSearch());
                  },
                ),

                SizedBox(
                  height: 10,
                ),
                Text(
                  "categories",
                  style: TextStyle(color: Colors.orange),
                ),
                SizedBox(
                  height: 10,
                ),

                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'ASSETS/Artboard 1 copy 17ldpi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              image: AssetImage(
                                'ASSETS/Artboard 1 copy 17ldpi.png',
                              ),
                              fit: BoxFit.cover),
                          color: isButtonPressed ? Colors.orange[800] : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isButtonPressed = !isButtonPressed;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SalonFirst()));
                          }),
                    ),


                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'ASSETS/Artboard 1 copy 20ldpi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              image: AssetImage(
                                'ASSETS/Artboard 1 copy 20ldpi.png',
                              ),
                              fit: BoxFit.cover),
                          color: isButtonPressed1 ? Colors.orange[800] : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isButtonPressed1 = !isButtonPressed1;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestorFirst()));
                          }),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'ASSETS/Artboard 1 copy 19ldpi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              image: AssetImage(
                                'ASSETS/Artboard 1 copy 19ldpi.png',
                              ),
                              fit: BoxFit.cover),
                          color: isButtonPressed2 ? Colors.orange[800] : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isButtonPressed2 = !isButtonPressed2;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClinicFirst()));
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Salons",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "Restaurants",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "Clinics",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'ASSETS/Artboard 1 copy 21ldpi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              image: AssetImage(
                                'ASSETS/Artboard 1 copy 21ldpi.png',
                              ),
                              fit: BoxFit.cover),
                          color: isButtonPressed3 ? Colors.orange[800] : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isButtonPressed3 = !isButtonPressed3;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DignoFirst()));
                          }),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'ASSETS/Artboard 1 copy 18ldpi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              image: AssetImage(
                                'ASSETS/Artboard 1 copy 18ldpi.png',
                              ),
                              fit: BoxFit.cover),
                          color: isButtonPressed4 ? Colors.orange[800] : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isButtonPressed4 = !isButtonPressed4;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CentreFirst()));
                          }),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'ASSETS/Artboard 1 copy 23ldpi.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image(
                              image: AssetImage(
                                'ASSETS/Artboard 1 copy 23ldpi.png',
                              ),
                              fit: BoxFit.cover),
                          color: isButtonPressed5 ? Colors.orange[800] : null,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isButtonPressed5 = !isButtonPressed5;
                            });
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Diagnostic\n   Centre",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Service\n Centre",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    Text(
                      "Gyms",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  void _launchURL(BuildContext context) async {
    try {
      await launch(
        'https://www.instagram.com/bookspot.app/',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  void _launchURL1(BuildContext context) async {
    try {
      await launch(
        'https://www.facebook.com/bookspotapp/',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }

  void _launchURL2(BuildContext context) async {
    try {
      await launch(
        'https://twitter.com/BookSpotapp',
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}
