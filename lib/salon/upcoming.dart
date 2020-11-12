import 'package:bookspot/favorites.dart';
import 'package:bookspot/main.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../ContainerClass.dart';
import '../homepage.dart';

class Upcoming extends StatefulWidget {

  @override
  _UpcomingState createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
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
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage("ASSETS/logo.png"),
        ),
        backgroundColor: HexColor("#f9692d"),
        elevation: 0.0,
      ),


      body: Form(
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
                            splashColor: Colors.purple,
                            onPressed: () {
                              Customer customer = new Customer();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(customer)));
                            },
                          ),

                          Text(
                            "Upcoming",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      FutureBuilder(
                        future: FirebaseDatabase.instance.reference().child("customers/${customer.uid}/services").orderByChild("st").endAt(3).once(),
                        builder: (context, data){
                          if(data.hasData){
                            DataSnapshot ds = data.data;

                            if(ds.value == null)
                              return Center(child: Text("Sorry! Nothing to show"),);
                            else {
                              Map<String, dynamic> orders = new Map<String, dynamic>.from(ds.value);
                              List<Order> oList = [];
                              orders.forEach((key, value) {
                                Map<String, dynamic> order = new Map<
                                    String,
                                    dynamic>.from(value);
                                Order o = new Order(
                                    order["fname"], order["Stype"], order["dt"],
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

                                    return Container(
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
                                              Text("Place Name      :",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0)),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              order.fname != null
                                                  ? Text(order.fname,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0))
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
                                                  "Category                   :",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0)),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              order.dt != null
                                                  ? Text(order.Stype,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0))
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
                                              Text("Date                   :",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0)),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              order.dt != null
                                                  ? Text(order.dt,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0))
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
                                              Text("Time Slot             :",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.0)),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(order.tm, style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0)),
                                            ],
                                          ),
                                          SizedBox(height: 30,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: [
                                              if (order.st == 1) Text(
                                                  "Pending") else
                                                Text("Accepted")
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  }
                              );
                            }
                          }
                          return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation(HexColor("#f9692d")),),);
                        },
                      )

                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
