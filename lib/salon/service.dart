import 'package:bookspot/salon/Date.dart';
import 'package:bookspot/salon/first.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../ContainerClass.dart';

class Services extends StatefulWidget {
  Customer customer;
  Shop shop;
  String fav, cat;
  Vendor vendor;

  Services(this.cat, this.customer, this.shop, this.fav, this.vendor);

  @override
  _ServicesState createState() => _ServicesState(cat, customer, shop, fav, vendor);
}

class _ServicesState extends State<Services> {
  int _itemCount = 1;
  Customer customer;
  Vendor vendor;
  Shop shop;
  String fav, cat;
  String sService = "Select Service";
  bool anyCompany = false;
  List<String> servicesList;

  _ServicesState(this.cat, this.customer, this.shop, this.fav, this.vendor);

  @override
  void initState() {
    // TODO: implement initState
    getDataFromDataBase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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

            body: vendor != null
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
                              splashColor: Colors.orange[800],
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SalonFirst(cat, customer, fav)));
                              },
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.all(15),

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
                                Row(
                                  children: [
                                    Text("$cat Name:"),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    vendor != null
                                        ? Container(
                                      width: 170,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        vendor.fname,
                                        style: TextStyle(
                                          color : Colors.black,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    )
                                        : Text(""),
                                  ],
                                ),


                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Address:"),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    vendor != null
                                        ? Container(
                                      width: 170,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        vendor.add,
                                        style: TextStyle(
                                          color : Colors.black,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    )
                                        : Text(""),
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
                                  child: DropdownButton<String>(
                                      value : sService,

                                      items: servicesList != null
                                          ? servicesList.map<DropdownMenuItem<String>>((String value){
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value),
                                        );
                                      }).toList()
                                          : [ DropdownMenuItem<String>(
                                        value: "abc",
                                        child: new Text("def"),
                                      )],

                                      onChanged: (value) {
                                        setState(() {
                                          sService = value;
                                        });
                                      }),
                                ),
                              )),

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
                              value: false,
                              textOn: 'Yes',
                              textOff: 'No',
                              colorOff: Colors.black,
                              colorOn: Colors.orange[800],
                              iconOff: Icons.remove_circle_outline,
                              iconOn: Icons.done,
                              textSize: 20.5,
                              onChanged: (bool state) {
                                anyCompany = state;
                                print('Current State of SWITCH IS: $state');
                              },
                            ),
                          ),

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
                            height: 50,
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

                              if(sService.compareTo("Select Service") != 0 && sService.compareTo("") != 0) {
                                print(
                                    "Service selected = $sService \nitemcount = $_itemCount \nanyCompany = $anyCompany");

                                OrderDetails orderDetails = new OrderDetails(customer.uid, customer.cno, sService, customer.nm, anyCompany, _itemCount);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Datetime(cat, customer, shop, orderDetails, vendor)));

                              }else{
                                Fluttertoast.showToast(
                                  msg: "Please select Service",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            splashColor: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )

                : Center(child : CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(HexColor("#f9692d")),)),
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

  void getDataFromDataBase() async {
    if(vendor == null) {
      DataSnapshot ds = await FirebaseDatabase.instance.reference().child(
          "vendors/${shop.uid}").once();
      Map<String, dynamic> item = new Map<String, dynamic>.from(ds.value);

      vendor = new Vendor(
          item["cno"],
          item["fname"],
          item["oname"],
          item["add"],
          item["email"],
          item["website"],
          item["addno"],
          item["cat"],
          item["services"],
          item["total_tokens"],
          item["sdate"],
          item["stime"],
          item["UID"],
          item["rat"],
          item["ltiming"],
          item["lat"],
          item["lng"],
          item["op"]);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Services(cat, customer, shop, fav, vendor)));
    }else{
      servicesList =  vendor.services.split(";");
      int l = servicesList.length;
      servicesList.removeAt(l-1);
      servicesList.add("Select Service");
      print("servicesList = $servicesList");
    }

  }
}
