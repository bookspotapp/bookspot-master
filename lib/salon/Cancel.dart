import 'dart:async';

import 'package:bookspot/ContainerClass.dart';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/history.dart';
import 'package:bookspot/main.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/salon/confirma.dart';
import 'package:bookspot/salon/upcoming.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../homepage.dart';

class Canclee extends StatefulWidget {
  OrderDetails orderDetails;
  Shop shop;
  String cat;
  Canclee(this.cat, this.shop, this.orderDetails);
  @override
  _CancleeState createState() => _CancleeState(cat, shop, orderDetails);
}

class _CancleeState extends State<Canclee> {
  OrderDetails orderDetails;
  Shop shop;
  String cat;

  _CancleeState(this.cat, this.shop, this.orderDetails);

  @override
  void initState() {
    // TODO: implement initState
    getDataFromDatabase();
    super.initState();
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


      body: orderDetails.tkn != null
      ? Form(
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
                          Customer customer = new Customer();
                          customer.uid = orderDetails.uid;
                          customer.nm = orderDetails.nm;
                          customer.cno = orderDetails.cno;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(customer)));
                        },
                      ),
                    ),


                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Hello, ${orderDetails.nm}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black, // set border color
                            width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(
                                10.0) //                 <--- border radius here
                            ),

                          image: DecorationImage(
                            image: AssetImage(
                                "ASSETS/ticket.png"
                            ),
                            fit: BoxFit.fill,
                          )
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                "Token No        :",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              orderDetails.tkn != null
                              ? Text(
                                "${orderDetails.tkn}",
                                style: TextStyle(color: Colors.white),
                              )
                              : Text(" "),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                "Date                 :",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "22 / 09 / 20",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 80,
                              ),
                              Text(
                                "Time                :",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "09 : 00 AM",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Your Place   :",
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "",
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
                              "Service Type :",
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "${orderDetails.Stype}",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                       /* Row(
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              "Waiting Time:",
                            ),
                            SizedBox(
                              width: 130,
                            ),
                            Text(
                              "00 : 02 :59",
                            ),
                          ],
                        ),

                        */
                      ],
                    ),

                    SizedBox(
                      height: 130,
                    ),

                    MaterialButton(
                      height: 52,
                      minWidth: 323,
                      color: Colors.red,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Customer customer = new Customer();
                        customer.uid = orderDetails.uid;
                        customer.nm = orderDetails.nm;
                        customer.cno = orderDetails.cno;
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomePage(customer)));
                      },
                      splashColor: Colors.yellowAccent,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )

      : Center(child : CircularProgressIndicator(valueColor: new  AlwaysStoppedAnimation<Color>(HexColor("#f9692d")),)),
    );
  }

  void getDataFromDatabase() async {
    if(orderDetails.tkn == null) {
      DataSnapshot ds = await FirebaseDatabase.instance.reference().child(
          "orders/${shop.uid}/tkn").once();
      orderDetails.tkn = ds.value + 1;
      String req = orderDetails.toString();
      print("req = $req");
      DatabaseReference reqRef = FirebaseDatabase.instance.reference().child("vendors/${shop.uid}");
      reqRef.child("req").set(req).then((value) => {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Upcoming()))
      });
    }
  }


}
