import 'package:bookspot/centres/centreconfirm.dart';
import 'package:bookspot/centres/firstcentres.dart';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/Date.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ServicesCetres extends StatefulWidget {
  @override
  _ServicesCetresState createState() => _ServicesCetresState();
}

class _ServicesCetresState extends State<ServicesCetres> {
  int _value = 1;
  int _itemCount = 0;
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
                                  builder: (context) => CentreFirst()));
                        },
                      ),
                    ),
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                          top: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 3.0,
                          ),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                              Text("Centre's Name:"),
                              SizedBox(
                                width: 130,
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
                              Text("Address:"),
                              SizedBox(
                                width: 150,
                              ),
                              Text("1 2 3 4 5"),
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
                    Container(
                        height: 50,
                        width: 290,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all()),
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                                value: _value,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Choose Services"),
                                    value: 1,
                                  ),
                                  DropdownMenuItem(
                                    child: Text("Second Item"),
                                    value: 2,
                                  ),
                                  DropdownMenuItem(
                                      child: Text("Third Item"), value: 3),
                                  DropdownMenuItem(
                                      child: Text("Fourth Item"), value: 4)
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _value = value;
                                  });
                                }),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Number of Person"),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all()),
                        child: Row(
                          children: [
                            new IconButton(
                              icon: new Icon(Icons.remove),
                              onPressed: () => setState(() => _itemCount--),
                            ),
                            new Text(_itemCount.toString()),
                            new IconButton(
                                icon: new Icon(Icons.add),
                                splashColor: Colors.orange,
                                onPressed: () => setState(() => _itemCount++))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Any Accompany"),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: 130,
                      child: LiteRollingSwitch(
                        //initial value
                        value: true,
                        textOn: 'No',
                        textOff: 'Yes',
                        colorOn: Colors.black,
                        colorOff: Colors.orange[800],
                        iconOn: Icons.remove_circle_outline,
                        iconOff: Icons.done,
                        textSize: 20.5,
                        onChanged: (bool state) {
                          print('Current State of SWITCH IS: $state');
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
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
                        "Proceed",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfiramationCentre()));
                      },
                      splashColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
