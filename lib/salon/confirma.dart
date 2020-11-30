import 'package:bookspot/ContainerClass.dart';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/Cancel.dart';
import 'package:bookspot/salon/Date.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Confiramation extends StatefulWidget {
  OrderDetails orderDetails;
  Shop shop;
  String cat;
  Confiramation(this.cat, this.shop, this.orderDetails);
  @override
  _ConfiramationState createState() => _ConfiramationState(cat, shop, orderDetails);
}

class _ConfiramationState extends State<Confiramation> {
  OrderDetails orderDetails;
  Shop shop;
  String cat;
  _ConfiramationState(this.cat, this.shop, this.orderDetails);

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
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
                            Navigator.of(context).pop();
                          },
                        ),

                        Text(
                          "Confirmation",
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
                      height: 160,
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
                              Text("Salon Name      :", style: TextStyle(color: Colors.white, fontSize: 15.0)),
                              SizedBox(
                                width: 30,
                              ),
                              shop.name != null
                                  ? Text(shop.name, style: TextStyle(color: Colors.white, fontSize: 15.0))
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
                              Text("Date                   :", style: TextStyle(color: Colors.white, fontSize: 15.0)),
                              SizedBox(
                                width: 30,
                              ),
                              orderDetails.bDate != null
                                  ? Text(orderDetails.bDate.split(" ")[0], style: TextStyle(color: Colors.white, fontSize: 15.0))
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
                              Text("Timings             :", style: TextStyle(color: Colors.white, fontSize: 15.0)),
                              SizedBox(
                                width: 30,
                              ),
                              Text(orderDetails.bTime, style: TextStyle(color: Colors.white, fontSize: 15.0)),
                            ],
                          ),
                        ],
                      ),
                    ),
                   /* SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Text("Expected Waiting Time:"),
                        SizedBox(
                          width: 10,
                        ),
                        Text("00 : 02 :59")
                      ],
                    ),

                    */
                    SizedBox(
                      height: 200,
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
                        "Confirm",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Canclee(cat, shop, orderDetails)));
                      },
                      splashColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
