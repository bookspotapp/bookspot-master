import 'dart:async';import 'package:bookspot/ContainerClass.dart';import 'package:bookspot/favorites.dart';import 'package:bookspot/history.dart';import 'package:bookspot/main.dart';import 'package:bookspot/privacy.dart';import 'package:bookspot/profile.dart';import 'package:bookspot/salon/confirma.dart';import 'package:bookspot/salon/upcoming.dart';import 'package:bookspot/settings.dart';import 'package:firebase_database/firebase_database.dart';import 'package:flutter/material.dart';import 'package:flutter/services.dart';import 'package:fluttertoast/fluttertoast.dart';import 'package:hexcolor/hexcolor.dart';import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';import '../homepage.dart';import '../service_time.dart';class Canclee extends StatefulWidget {	OrderDetails orderDetails;	Shop shop;	String cat;	Canclee(this.cat, this.shop, this.orderDetails);	@override	_CancleeState createState() => _CancleeState(cat, shop, orderDetails);}class _CancleeState extends State<Canclee> {	OrderDetails orderDetails;	Shop shop;	String cat;	int percent = 0;	_CancleeState(this.cat, this.shop, this.orderDetails);	@override	void initState() {		// TODO: implement initState		getDataFromDatabase();		initializeTimer();		super.initState();	}	@override	Widget build(BuildContext context) {		return SafeArea(			child:	Scaffold(				appBar: AppBar(					leading: Image(						image: AssetImage("ASSETS/logo.png"),					),					backgroundColor: HexColor("#f9692d"),					elevation: 0.0,				),				body: orderDetails.tkn != null						? Form(					child: Stack(						fit: StackFit.expand,						children: <Widget>[							Padding(								padding: const EdgeInsets.all(8.0),								child: Center(									child: Column(										children: [											Padding(												padding: const EdgeInsets.only(right: 300),												child: IconButton(													icon: Icon(														Icons.arrow_back_ios,													),													iconSize: 30,													color: Colors.black,													splashColor: Colors.orange[800],													onPressed: () {														Customer customer = new Customer();														customer.uid = orderDetails.uid;														customer.nm = orderDetails.nm;														customer.cno = orderDetails.cno;														Navigator.pushReplacement(																context,																MaterialPageRoute(																		builder: (context) => HomePage(customer)));													},												),											),											SizedBox(												height: 20,											),											Row(												children: [													SizedBox(														width: 20,													),													Text(														"Hello, ${orderDetails.nm}",														style: TextStyle(																color: Colors.black,																fontSize: 25,																fontWeight: FontWeight.bold),													),												],											),											SizedBox(												height: 10,											),											Container(												height: 150,												decoration: BoxDecoration(														image: DecorationImage(															image: AssetImage(																	"ASSETS/ticket.png"															),															fit: BoxFit.fill,														)												),												child: Column(													children: [														SizedBox(															height: 30,														),														Row(															children: [																SizedBox(																	width: 80,																),																Text(																	"Token No        :",																	style: TextStyle(color: Colors.white),																),																SizedBox(																	width: 30,																),																orderDetails.tkn != null																		? Text("${orderDetails.tkn}", style: TextStyle(color: Colors.white),)																		: Text(" "),															],														),														SizedBox(															height: 10,														),														Row(															children: [																SizedBox(																	width: 80,																),																Text(																	"Date                 :",																	style: TextStyle(color: Colors.white),																),																SizedBox(																	width: 30,																),																orderDetails.bDate != null																		?	RichText(text: TextSpan(text: orderDetails.bDate, style: TextStyle(color: Colors.white),))																		: Text(" "),															],														),														SizedBox(															height: 10,														),														Row(															children: [																SizedBox(																	width: 80,																),																Text(																	"Time                :",																	style: TextStyle(color: Colors.white),																),																SizedBox(																	width: 30,																),																orderDetails.bTime != null																		?	RichText(text: TextSpan(text: orderDetails.bTime, style: TextStyle(color: Colors.white),))																		:	Text(" "),															],														),													],												),											),											SizedBox(												height: 30,											),											Column(												children: [													Row(														children: [															SizedBox(																width: 30,															),															Text(																"Your Place   :",															),															SizedBox(																width: 50,															),															FutureBuilder(																future: FirebaseDatabase.instance.reference().child("orders/${shop.uid}/tkn_d").once(),																builder: (context, data){																	if(data.hasData){																		DataSnapshot ds = data.data;																		int td = ds.value;																		int t = orderDetails.tkn;																		return Text((t-td).toString());																	}																	return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(HexColor("#f9692d")),);																},															)														],													),													SizedBox(														height: 10,													),													Row(														children: [															SizedBox(																width: 30,															),															Text(																"Service Type :",															),															SizedBox(																width: 50,															),															Text(																"${orderDetails.Stype}",															),														],													),													SizedBox(														height: 30,													),													/* Row(                          children: [                            SizedBox(                              width: 30,                            ),                            Text(                              "Waiting Time:",                            ),                            SizedBox(                              width: 130,                            ),                            Text(                              "00 : 02 :59",                            ),                          ],                        ),                        */												],											),											LiquidLinearProgressIndicator(												valueColor: AlwaysStoppedAnimation(HexColor("#f9692d")),												backgroundColor: Colors.white,												borderColor: HexColor("#f9692d"),												borderWidth:4.0,												borderRadius: 5.0,												direction: Axis.horizontal,												center:Text("Waiting for Vendor Response....", style: TextStyle(color: Colors.black)),											),											SizedBox(												height: 30,											),											MaterialButton(												height: 52,												minWidth: 323,												color: HexColor("#f9692d"),												textColor: Colors.white,												shape: RoundedRectangleBorder(													borderRadius: BorderRadius.circular(24.0),												),												child: Text(													"Cancel",													style: TextStyle(color: Colors.white, fontSize: 20.0),												),												onPressed: () {													DatabaseReference tknRef = FirebaseDatabase.instance.reference().child("orders/${shop.uid}/tkn");													tknRef.set(orderDetails.tkn);													DatabaseReference ref = FirebaseDatabase.instance.reference().child("customers/${orderDetails.uid}/services/${shop.uid}/");													ref.set(null);													DatabaseReference vendorRef = FirebaseDatabase.instance.reference().child("vendors/${shop.uid}/req");													vendorRef.set(null);													Customer customer = new Customer();													customer.uid = orderDetails.uid;													customer.nm = orderDetails.nm;													customer.cno = orderDetails.cno;													Navigator.pushReplacement(context,															MaterialPageRoute(builder: (context) => HomePage(customer)));												},												splashColor: Colors.yellowAccent,											)										],									),								),							),						],					),				)						: Center(child : CircularProgressIndicator(valueColor: new  AlwaysStoppedAnimation<Color>(HexColor("#f9692d")),)),			)		);	}	void getDataFromDatabase() async {		if(orderDetails.tkn == null) {			DataSnapshot ds = await FirebaseDatabase.instance.reference().child(					"orders/${shop.uid}/tkn").once();			orderDetails.tkn = ds.value + 1;			Order order = new Order(shop.name, orderDetails.Stype, orderDetails.bDate, orderDetails.bTime, shop.uid, 1);			DatabaseReference orderRef = FirebaseDatabase.instance.reference().child("customers/${customer.uid}/services/${order.vid}/");			orderRef.set(<String, Object>{				"name" : order.fname,				"Stype" : order.Stype,				"dt" : order.dt,				"tm" : order.tm,				"st" : order.st,				"vid" : order.vid,			});			String req = orderDetails.toString();			print("req = $req");			DatabaseReference reqRef = FirebaseDatabase.instance.reference().child("vendors/${shop.uid}");			reqRef.child("req").set(req).then((value) => {			Navigator.pushReplacement(context,			MaterialPageRoute(builder: (context) => Canclee(cat, shop, orderDetails)))			});		}	}  void initializeTimer() {		Timer timer;		timer = Timer.periodic(Duration(milliseconds: 1000), (_) {			print('Percent Update');			setState(()  {				percent += 5;				if (percent >= 100) {					timer.cancel();					forwardToNextScreen();				}			});		});	}  void forwardToNextScreen() async{		DataSnapshot ds = await FirebaseDatabase.instance.reference().child("customers/${customer.uid}/services/${shop.uid}/st").once();		if(ds.value == 2)			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Time(customer, new Order(shop.name, orderDetails.Stype, orderDetails.bDate, orderDetails.bTime, shop.uid, ds.value))));		else{			FirebaseDatabase.instance.reference().child("customers/${customer.uid}/services/${shop.uid}/st").set(2);// Setting the Status of service to 2 means its cancel			FirebaseDatabase.instance.reference().child("vendors/${shop.uid}/req").set(null); // Setting the value of requests of oreder on vendor side to null			Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(customer)));			if(ds.value == 3)				Fluttertoast.showToast(msg: "Sorry!, Vendor declined.");			else				Fluttertoast.showToast(msg: "Sorry!, Vendor doesn't responded.");		}	}}