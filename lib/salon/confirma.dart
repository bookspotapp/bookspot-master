import 'package:bookspot/ContainerClass.dart';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/salon/Cancel.dart';
import 'package:bookspot/salon/Date.dart';
import 'package:bookspot/salon/upcoming.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class Confiramation extends StatefulWidget {
  OrderDetails orderDetails;
  Vendor vendor;
  int tkn;
  Shop shop;
  String cat;
  Confiramation(this.cat, this.shop, this.orderDetails, this.vendor);
  @override
  _ConfiramationState createState() => _ConfiramationState(cat, shop, orderDetails, vendor);
}

class _ConfiramationState extends State<Confiramation> {
  OrderDetails orderDetails;
  Shop shop;
  String cat;
  Vendor vendor;
  bool buttonVisibility = true, progressVisibility = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  _ConfiramationState(this.cat, this.shop, this.orderDetails, this.vendor);

  @override
  void initState() {
    // TODO: implement initState
    double avgTime = 60/int.parse(vendor.total_tokens);
    var initializationSettingsAndroid = AndroidInitializationSettings("@drawable/logo");
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    initializeFirebase();
    configureLocalTimeZone();
    super.initState();
  }

  Future onSelectNotification(String payload) async {
    print("payload = $payload");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Customer customer = Customer();
    customer.uid = preferences.getString("uid");
    customer.nm = preferences.getString("nm");
    customer.cno = preferences.getString("cno");
    customer.email = preferences.getString("email");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Upcoming(customer)));
  }

  showNotification() async {
    var android = AndroidNotificationDetails(
        '123', 'Booking Alert', 'Alerting about upcoming spots',
        priority: Priority.high,
        importance: Importance.max,
      playSound: true,
    );
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Booking Alert', 'Your booking is coming soon...', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  Future<void> scheduleNotification(var scheduledNotificationDateTime) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '123',
      'Booking Alert',
      'Alerting about upcoming spots',
      icon: '@drawable/logo',
      largeIcon: DrawableResourceAndroidBitmap('@drawable/logo'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    print("platform channl = ${platformChannelSpecifics}");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        123,
        'Booking Alert',
        'Your booking is coming soon...',
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
    );
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
                    SizedBox(
                      height: 10,
                    ),



                    SizedBox(
                      height: 200,
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
                          "Confirm",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () async {

                          setState(() {
                            buttonVisibility = false;
                            progressVisibility = true;
                          });

                          Order order = new Order(shop.name, orderDetails.Stype, orderDetails.bDate, orderDetails.bTime, shop.uid, 1);
                          DatabaseReference orderRef = FirebaseDatabase.instance.reference().child("customers/${customer.uid}/services/${order.vid}/");
                          orderRef.set(<String, Object>{
                            "name" : order.fname,
                            "Stype" : order.Stype,
                            "dt" : order.dt,
                            "tm" : order.tm,
                            "st" : order.st,
                            "vid" : order.vid,
                          });

                          List<String> s = orderDetails.bTime.split(" ");
                          int hr = 0;
                          if(s.last.compareTo("PM") == 0){
                            hr = int.parse(s[0]) + 12;
                          }else{
                            hr = 0;
                          }
                          String time;
                          if(hr <10)
                            time = "0$hr:00:00";
                          else
                            time = "$hr:00:00";


                          DateTime _1hr = DateTime.parse("${orderDetails.bDate} $time").subtract(new Duration(hours: 1));
                          DateTime _15min = DateTime.parse("${orderDetails.bDate} $time").subtract(new Duration(minutes: 15));

                          final tz_1hr = tz.TZDateTime.from(_1hr, tz.local);
                          final tz_15min = tz.TZDateTime.from(_15min, tz.local);

                          print("datetime = ${orderDetails.bDate} $time");
                          print("_1hr = $tz_1hr _15min = $tz_15min");

                          scheduleNotification(tz_1hr);
                          scheduleNotification(tz_15min);

                          String req = orderDetails.toString();
                          print("req = $req");
                          DatabaseReference reqRef = FirebaseDatabase.instance.reference().child("vendors/${shop.uid}");
                          reqRef.child("req").push().set(req).then((value) => {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Canclee(cat, shop, orderDetails)))
                          });
                        },
                        splashColor: Colors.redAccent,
                      ),
                    ),

                    Visibility(
                        visible: progressVisibility,
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),)
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

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }
}
