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
  int myPlace;
  String token_value;

  Time(this.customer, this.order, this.myPlace, this.token_value);

  @override
  _TimeState createState() => _TimeState(customer, order, myPlace, token_value);
}

class _TimeState extends State<Time> {
  int tkn = 0;
  Customer customer;
  Order order;
  int myPlace;
  String token_value;

  _TimeState(this.customer, this.order, this.myPlace, this.token_value);

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
    if(token_value != null && token_value.isNotEmpty)
      setTimerDuration();
    else
      getTknDetails();
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

          body: token_value != null && token_value.isNotEmpty
          ? Form(
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
                          Text(token_value)
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
                          if (myPlace == -1) Text("Not alloted") else Text("$myPlace"),
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
          )
          : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),)),
        )
    );
  }

  void setTimerDuration() {
    List<String> dt = order.dt.split("-");
    List<String> tm = order.tm.split(" ");

    print("dt = $dt tm = $tm");

    if(tm.last.compareTo("PM") == 0){
      tm[0] = (int.parse(tm[0]) + 12).toString();
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

  void getTknDetails() async {
    DataSnapshot tkn = await FirebaseDatabase.instance.reference().child("orders/${order.vid}/order/${customer.uid}/tkn").once();
    DataSnapshot tkn_d = await FirebaseDatabase.instance.reference().child("orders/${order.vid}/tkn_d").once();

    int token = tkn.value;
    int myPlace = -1;

    int hr = 0;
    if(order.tm.split(" ")[3].compareTo("PM") == 0 && order.tm.split(" ")[0].compareTo("11") != 0 && order.tm.split(" ")[0].compareTo("12") != 0){
      hr += 12;
    }
    hr += int.parse(order.tm.split(" ")[0]);

    if(tkn_d.value != null) {
      String dls = tkn_d.value;
      List<String> dl = dls.split("-");
      if(int.parse(dl[0]) == hr)
        myPlace = token - int.parse(dl.last);
      else
        myPlace = token;
    }else{
      DateTime now = DateTime.now();
      if(now.hour == hr)
        myPlace = tkn.value;
      else
        myPlace = token;
    }

    String token_value = "${order.tm.split(" ")[0]}$token";
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Time(customer, order, myPlace, token_value)));
  }

}