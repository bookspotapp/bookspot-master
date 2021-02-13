import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/MultiSelectChip.dart';
import 'package:bookspot/salon/confirma.dart';
import 'package:bookspot/salon/service.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  Vendor vendor;

  Datetime(this.cat, this.customer, this.shop, this.orderDetails, this.vendor);

  @override
  _DateTimeState createState() => _DateTimeState(cat, customer, shop, orderDetails, "", vendor);
}

class _DateTimeState extends State<Datetime> {
  List<bool> isButtonPressed = [false,false,false,false,false,false,false,false,false];
  Shop shop;
  String cat;
  Customer customer;
  OrderDetails orderDetails;
  String Time = "";
  Vendor vendor;
  int x = 0, y = 0;

  _DateTimeState(this.cat, this.customer, this.shop, this.orderDetails, this.Time, this.vendor);

  @override
  CalendarController _controller;
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String SelectedTimeSlot = "";
    bool buttonVisibility = true, progressVisibility = false;

    return SafeArea(
      child: Scaffold(
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
                            splashColor: Colors.orange[800],
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
                          todayColor: Colors.grey,
                          weekendStyle: TextStyle(color: Colors.black),
                          selectedColor: Colors.orange[800],
                        ),
                        calendarController: _controller,
                        onDaySelected: (DateTime dt, List<dynamic> l1, List<dynamic> l2){
                          setState(() {
                            x += 1;
                            Future.delayed(Duration(milliseconds: 100), (){
                              setState(() {
                                y += 1;
                              });
                            });
                          });
                        },
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

                    x == y
                    ? FutureBuilder(
                      future: FirebaseDatabase.instance.reference().child("vendors/${shop.uid}/stime").once(),
                      builder: (context, data ){
                        if(data.hasData){
                          DataSnapshot ds = data.data;
                          String timeSlots = ds.value;
                          List<String> TimeSlotList = timeSlots.split(";");
                          TimeSlotList.removeLast();

                          return MultiSelectChip(
                            timeSlotList: TimeSlotList,
                            height: height,
                            onClick: (data){
                              SelectedTimeSlot = data;
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(HexColor("f9692d")),),);
                      },
                    )

                    : Center(
                      child:  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),),
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
                    Visibility(
                        visible: buttonVisibility,
                        child: MaterialButton(
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
                          onPressed: () async {

                            setState(() {
                              buttonVisibility = false;
                              progressVisibility = true;
                            });

                            DateTime today = DateTime.now();
                            List<String> d = _controller.selectedDay.toString().split(" ");
                            int day = _controller.selectedDay.weekday;
                            int op = -1;

                            switch(vendor.op){
                              case "Monday" :
                                op = 1;
                                break;
                              case "Tuesday":
                                op = 2;
                                break;
                              case "Wednesday":
                                op = 3;
                                break;
                              case "Thrusday":
                                op = 4;
                                break;
                              case "Friday":
                                op = 5;
                                break;
                              case "Saturday":
                                op = 6;
                                break;
                              case "Sunday":
                                op = 7;
                                break;
                            }

                            print("Date = ${_controller.selectedDay.toString()} and today = $today");


                            if(SelectedTimeSlot.isEmpty)
                              Fluttertoast.showToast(
                                msg: "Please select a Time Slot",
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );

                            if(day == op)
                              Fluttertoast.showToast(
                                msg: "Please select another day\n $cat is closed on this day.",
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );

                            if(day != op  && SelectedTimeSlot.isNotEmpty ){
                              orderDetails.bDate = d[0];
                              orderDetails.bTime = SelectedTimeSlot;

                              int index = 0;

                              List<String> s = SelectedTimeSlot.split(" ");
                              if(s.last.compareTo("PM") == 0 && s[0].compareTo("11") != 0 && s[0].compareTo("12") != 0)
                                index = 12;
                              else
                                index = 0;
                              index += int.parse(s[0]);
                              print("index = $index");

                              int hr = 0;
                              if(s.last.compareTo("PM") == 0 && s[2].compareTo("11") != 0 && s[2].compareTo("12") != 0)
                                hr = 12;
                              else
                                hr = 0;
                              hr += int.parse(s[2]);
                              print("hr = $hr");

                              DateTime selectedDate;
                              if(hr < 10)
                                selectedDate = DateTime.parse("${d[0]} 0$hr:00:00");
                              else
                                selectedDate = DateTime.parse("${d[0]} $hr:00:00");

                              print("selected date = $selectedDate today = $today");
                              print("bool = ${selectedDate.isBefore(today)}");

                              if(selectedDate.isBefore(today))
                                Fluttertoast.showToast(
                                  msg: "Please select another date or time",
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              else {
                                DataSnapshot ds = await FirebaseDatabase
                                    .instance.reference()
                                    .child(
                                    "orders/${vendor.UID}/sch/${d[0]}/$index")
                                    .once();

                                print("add = orders/${vendor.UID}/sch/${d[0]}/$index");
                                if (ds.value != null &&
                                    ds.value < int.parse(vendor.total_tokens)) {
                                  print("ds.value = ${ds.value}");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Confiramation(
                                                  cat, shop, orderDetails, vendor)));
                                }else if (ds.value == null){
                                  print("ds.value = ${ds.value}");
                                  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) =>
                                      Confiramation(
                                        cat, shop, orderDetails, vendor)));
                            }else if (ds.value != null &&
                                    ds.value > vendor.total_tokens)
                                  Fluttertoast.showToast(
                                    msg: "Please select another day or time slot.",
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                  );
                              }

                            }

                          },
                          splashColor: Colors.redAccent,
                        )
                    ),

                    Visibility(
                      visible: progressVisibility,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );

  }

  Future<bool> checkDateandTime(String d, String selectedTimeSlot) async {
    DataSnapshot ds = await FirebaseDatabase.instance.reference().child("vendors/${vendor.UID}/orders/$d/$selectedTimeSlot").once();

  }
}
