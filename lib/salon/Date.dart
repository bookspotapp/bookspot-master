import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/confirma.dart';
import 'package:bookspot/salon/service.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range/time_range.dart';

class DateTime extends StatefulWidget {
  @override
  _DateTimeState createState() => _DateTimeState();
}

class _DateTimeState extends State<DateTime> {
  bool isButtonPressed = false;
  bool isButtonPressed1 = false;
  bool isButtonPressed2 = false;
  bool isButtonPressed3 = false;
  bool isButtonPressed4 = false;
  bool isButtonPressed5 = false;
  bool isButtonPressed6 = false;
  bool isButtonPressed7 = false;
  bool isButtonPressed8 = false;
  @override
  CalendarController _controller;
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

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
        child: Stack(fit: StackFit.expand, children: <Widget>[
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
                                builder: (context) => Services()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 250),
                    child: Text(
                      "Date",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all()),
                    child: TableCalendar(
                      initialCalendarFormat: CalendarFormat.week,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle: TextStyle().copyWith(color: Colors.black),
                      ),
                      calendarStyle: CalendarStyle(
                        todayColor: Colors.purple,
                        weekendStyle: TextStyle(color: Colors.black),
                        selectedColor: Colors.orange[800],
                      ),
                      calendarController: _controller,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 250),
                    child: Text(
                      "Time",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "09:30 am",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed = !isButtonPressed;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Bank()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "10:00 am",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed1
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed1 = !isButtonPressed1;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "10:30 am",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed2
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed2 = !isButtonPressed2;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "11:00 am",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed3
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed3 = !isButtonPressed3;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "11:30 am",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed4
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed4 = !isButtonPressed4;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "12:00 pm",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed5
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed5 = !isButtonPressed5;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "12:00 pm",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed6
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed6 = !isButtonPressed6;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "12:00 pm",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed7
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed7 = !isButtonPressed7;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                "12:00 pm",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed8
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed8 = !isButtonPressed8;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Restaurant()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // TimeRange(
                  //   fromTitle: Text(
                  //     'From',
                  //     style: TextStyle(fontSize: 18, color: Colors.grey),
                  //   ),
                  //   toTitle: Text(
                  //     'To',
                  //     style: TextStyle(fontSize: 18, color: Colors.grey),
                  //   ),
                  //   titlePadding: 20,
                  //   textStyle: TextStyle(
                  //       fontWeight: FontWeight.normal, color: Colors.black87),
                  //   activeTextStyle: TextStyle(
                  //       fontWeight: FontWeight.bold, color: Colors.white),
                  //   borderColor: Colors.grey,
                  //   backgroundColor: Colors.transparent,
                  //   activeBackgroundColor: Colors.orange,
                  //   firstTime: TimeOfDay(hour: 14, minute: 30),
                  //   lastTime: TimeOfDay(hour: 20, minute: 00),
                  //   timeStep: 10,
                  //   timeBlock: 30,
                  //   onRangeCompleted: (range) => setState(() => print(range)),
                  // )
                  SizedBox(
                    height: 20,
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
                              builder: (context) => Confiramation()));
                    },
                    splashColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
