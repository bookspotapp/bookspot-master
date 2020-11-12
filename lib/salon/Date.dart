import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/confirma.dart';
import 'package:bookspot/salon/service.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:time_range/time_range.dart';

import '../ContainerClass.dart';

class Datetime extends StatefulWidget {

  String cat;
  Shop shop;
  Customer customer;
  OrderDetails orderDetails;

  Datetime(this.cat, this.customer, this.shop, this.orderDetails);

  @override
  _DateTimeState createState() => _DateTimeState(cat, customer, shop, orderDetails);
}

class _DateTimeState extends State<Datetime> {
  List<bool> isButtonPressed = [false,false,false,false,false,false,false,false,false];
  Shop shop;
  String cat;
  Customer customer;
  OrderDetails orderDetails;

  _DateTimeState(this.cat, this.customer, this.shop, this.orderDetails);

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


      body: Form(
        child: Stack(fit: StackFit.expand, children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Row(
                    children :[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        iconSize: 30,
                        color: Colors.black,
                        splashColor: Colors.purple,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),

                      Text(
                        "Select Date",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
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
                  Text(
                    "Select Time Slot",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 20,
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
                                "06:00 - 08:00",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[0]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[0] = !isButtonPressed[0];
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
                                "08:00 - 10:00",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[1]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[1] = !isButtonPressed[1];
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
                                "10:00 - 11:30",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[2]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[2] = !isButtonPressed[2];
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
                                "11:30 - 13:00",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[3]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[3] = !isButtonPressed[3];
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
                                "13:00 - 15:30",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[4]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[4] = !isButtonPressed[4];
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
                                "15:30 - 17:30",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[5]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[5] = !isButtonPressed[5];
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
                                "17:30 - 19:30",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[6]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[6] = !isButtonPressed[6];
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
                                "19:30 - 21:30",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[7]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[7] = !isButtonPressed[7];
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
                                "21:00 - 23:30",
                                style: TextStyle(fontSize: 15),
                              ),
                              color: isButtonPressed[8]
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed[8] = !isButtonPressed[8];
                                });
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
                    height: 40,
                  ),
                  MaterialButton(
                    height: 52,
                    minWidth: 323,
                    color: HexColor("#f9692d"),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Text(
                      "Proceed",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      int count = 0, pos = -1;
                      for(int i=0; i<isButtonPressed.length; i++){
                        if(isButtonPressed[i]) {
                          count++;
                          pos = i;
                        }
                      }

                      if(count == 0)
                        Fluttertoast.showToast(
                          msg: "Please select a Time Slot",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                      else if(count == 1){
                        switch(pos){
                          case 0:
                            orderDetails.bTime ="06:00 - 08:00";
                            break;

                          case 1:
                            orderDetails.bTime ="08:00 - 10:00";
                            break;

                          case 2:
                            orderDetails.bTime ="10:00 - 11:30";
                            break;
                          case 3:
                            orderDetails.bTime ="11:30 - 13:00";
                            break;

                          case 4:
                            orderDetails.bTime ="13:00 - 15:30";
                            break;

                          case 5:
                            orderDetails.bTime ="15:30 - 17:30";
                            break;
                          case 6:
                            orderDetails.bTime ="17:30 - 19:30";
                            break;

                          case 7:
                            orderDetails.bTime ="19:30 - 21:30";
                            break;

                          case 8:
                            orderDetails.bTime ="21:30 - 23:30";
                            break;
                        }

                        orderDetails.bDate = _controller.selectedDay.toString();
                        print("orderDetails = $orderDetails");

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Confiramation(cat, shop, orderDetails)));

                      }else if (count > 1 )

                        Fluttertoast.showToast(
                          msg: "Please select single time Slot\n and unselect others",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );

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
