import 'package:bookspot/favorites.dart';
import 'package:bookspot/main.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../ContainerClass.dart';
import '../homepage.dart';
import '../service_time.dart';

class Upcoming extends StatefulWidget {
  Customer customer;
  Upcoming(this.customer);
  @override
  _UpcomingState createState() => _UpcomingState(customer);
}

class _UpcomingState extends State<Upcoming> {
  Customer customer;

  _UpcomingState(this.customer);

  @override
  void initState() {
    // TODO: implement initState
    setup();
    super.initState();
  }
  void setup() async  {
    await Firebase.initializeApp();
  }
  @override
  Widget build(BuildContext context) {

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

            body: customer.uid != null
            ? Form(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                  iconSize: 30,
                                  color: Colors.black,
                                  splashColor: Colors.orange[800],
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage(customer)));
                                  },
                                ),

                                Text(
                                  "Upcoming Spots",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            FutureBuilder(
                              future: FirebaseDatabase.instance.reference().child("customers/${customer.uid}/services").orderByChild("st").endAt(2).once(),
                              builder: (context, data){
                                if(data.hasData){
                                  DataSnapshot ds = data.data;

                                  if(ds.value == null)
                                    return Center(
                                      child:Text("Sorry! Nothing to show", style: TextStyle(color: Colors.orange, fontSize: 20),),
                                    );
                                  else {
                                    Map<String, dynamic> orders = new Map<String, dynamic>.from(ds.value);
                                    List<Order> oList = [];
                                    orders.forEach((key, value) {
                                      Map<String, dynamic> order = new Map<
                                          String,
                                          dynamic>.from(value);
                                      Order o = new Order(
                                          order["name"], order["Stype"], order["dt"],
                                          order["tm"], order["vid"], order["st"]);
                                      oList.add(o);
                                    });

                                    print("length of oList = ${oList.length}");

                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: oList.length,
                                        itemBuilder: (context, index) {
                                          Order order = oList[index];

                                          return GestureDetector(
                                            onTap: (){
                                              Navigator.pushReplacement(context, MaterialPageRoute(  builder: (context) => Time(customer, order, -1, null),));
                                            },
                                            child: Container(
                                              height: 200,
                                              decoration: BoxDecoration(
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
                                                      Text("Place Name:",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15.0)),
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      order.fname != null
                                                          ? RichText(
                                                              text: TextSpan(
                                                                  text:  order.fname.length<=10 ? order.fname : "${order.fname.substring(0,8)}...",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 15.0)
                                                              ),
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
                                                          "Category:",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15.0)),
                                                      SizedBox(
                                                        width: 50,
                                                      ),
                                                      order.Stype != null
                                                          ? RichText(
                                                        text: TextSpan(
                                                            text:  order.Stype,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.0)
                                                        ),
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
                                                      Text("Date:",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15.0)),
                                                      SizedBox(
                                                        width: 80,
                                                      ),
                                                      order.dt != null
                                                          ? RichText(
                                                        text: TextSpan(
                                                            text:  order.dt,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.0)
                                                        ),
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
                                                      Text("Time Slot:",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 15.0)),
                                                      SizedBox(
                                                        width: 45,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                            text:  order.tm,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontSize: 15.0)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 30,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      if (order.st == 1)
                                                        Text("Pending")
                                                      else if(order.st == 2)
                                                        FutureBuilder(
                                                          future : FirebaseDatabase.instance.reference().child("vendors/${order.vid}/req").once(),
                                                          builder: (context, data){
                                                            if(data.hasData){
                                                              DataSnapshot ds = data.data;
                                                              if(ds.value != null){
                                                                return Text("Waiting for Vendor's Response");
                                                              }else
                                                                return  Text("Accepted");
                                                            }
                                                            return Text("");
                                                          },
                                                        )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );
                                  }
                                }
                                return Center(
                                  child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation(HexColor("#f9692d")),),
                                );
                              },
                            )

                          ],
                        ),
                      ),
                    )
                  ],
                ))
            : Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),),),
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
}


