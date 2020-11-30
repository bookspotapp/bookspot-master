import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';

import 'ContainerClass.dart';
import 'homepage.dart';

class Time extends StatefulWidget {
  Customer customer;
  Order order;

  Time(this.customer, this.order);

  @override
  _TimeState createState() => _TimeState(customer, order);
}

class _TimeState extends State<Time> {
  int tkn = 0;
  Customer customer;
  Order order;


  _TimeState(this.customer, this.order);

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    initializeFirebase();
    startTimeout();
    setTimerDuration();
    super.initState();
  }

  Duration _duration;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: Image(
                image: AssetImage("ASSETS/logo.png"),
              ),
            ),
            backgroundColor: HexColor("#f9692d"),
            elevation: 0.0,
          ),

          body: Form(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time in Your Service",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            SlideCountdownClock(
                              duration: _duration,
                              slideDirection: SlideDirection.Up,
                              separator: ":",
                              textStyle: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                              shouldShowDays: true,
                            ),
                          ]
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Days",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Hour",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Min",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Sec",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(height: 160),
                      Row(
                        children: [
                          Text(
                            "Token No:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30,),
                          FutureBuilder(
                            future: FirebaseDatabase.instance.reference().child("orders/${order.vid}/tkn").once(),
                            builder: (context, data){
                              if(data.hasData){
                                DataSnapshot ds = data.data;

                                tkn = ds.value;

                                return ds.value != null
                                    ? Text(
                                  (ds.value).toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : Text("Loading....");
                              }
                              return Text('Loading....');
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Your Turn:",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 30,),
                          FutureBuilder(
                            future: FirebaseDatabase.instance.reference().child("orders/${order.vid}/tkn_d").once(),
                            builder: (context, data){
                              if(data.hasData && tkn != 0){
                                DataSnapshot ds = data.data;

                                return ds.value != null
                                    ? Text(
                                  (tkn - ds.value).toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : Text("Loading....");
                              }
                              return Text('Loading....');
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 120),
                      MaterialButton(
                        height: 52,
                        minWidth: 323,
                        color: Colors.orange[800],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Text(
                          "Go to HomePage",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => HomePage(customer)
                          ));
                        },
                        splashColor: Colors.redAccent,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  void setTimerDuration() {
    List<String> dt = order.dt.split("-");
    List<String> tm = order.tm.split(" ");

    print("dt = $dt tm = $tm");

    if(tm[3].compareTo("PM") == 0){
      tm[0] = (int.parse(tm[0]) + 24).toString();
    }

    DateTime now = DateTime.now();
    DateTime date = DateTime(int.parse(dt[0]), int.parse(dt[1]), int.parse(dt[2]), int.parse(tm[0]));

    int seconds = date.difference(now).inSeconds;

    print("seconds = $seconds");

      _duration = new Duration(
          seconds: seconds
      );

  }

  void initializeFirebase() async {
    await Firebase.initializeApp();

    print("order = ${order.vid}");
  }
}