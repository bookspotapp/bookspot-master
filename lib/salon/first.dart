import 'dart:convert';
import 'dart:typed_data';
import 'package:bookspot/favorites.dart';
import 'package:bookspot/homepage.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/salon/service.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import '../ContainerClass.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import "Date.dart";
import 'SearchSpot.dart';

class SalonFirst extends StatefulWidget {
  Customer customer;
  String favList, cat;

  SalonFirst(this.cat, this.customer, this.favList);

  @override
  _SalonFirstState createState() => _SalonFirstState(customer, favList, cat);
}

class _SalonFirstState extends State<SalonFirst> {

  Customer customer;
  List<Shop> sList = [];
  List<Shop> favList = [];
  String fav = "";
  String cat;
  Position _currentPosition;
  Vendor vendor;
  bool isfav = false;
  DatabaseReference ref;
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  SearchBarController _searchBarController;



  _SalonFirstState(this.customer, this.fav, this.cat);

  @override
  void initState() {
    // TODO: implement initState
    initializeLists();
    _getCurrentLocation();
    super.initState();
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


            body: Form(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    child: Padding(
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
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                          builder: (context) => HomePage(customer)
                                      ));
                                    },
                                  ),

                                  Text(
                                    "${cat}s",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Search a Spot',
                                  prefixIcon: Icon(Icons.search),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchSpot(customer, fav, cat)));
                                },
                              ),






                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Nearby ${cat}s",
                                    style: TextStyle(
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),



                              SizedBox(
                                height: 10,
                              ),
                              Text("Choose From Favorites"),

                              SizedBox(
                                height: 20,
                              ),

                              FutureBuilder(
                                  future: ref.once(),
                                  builder :(context, data) {
                                    if(data.hasData)  {
                                      DataSnapshot ds = data.data;

                                      if(favList.length > 0)
                                        favList.clear();

                                      if(ds.value != null) {
                                        Map<String, dynamic> values = new Map<String, dynamic>.from(ds.value);
                                        print("values = $values");

                                        values.forEach((key, val) {
                                          Map <String, dynamic> m = new Map<
                                              String,
                                              dynamic>.from(val);
                                          Shop shop = new Shop(
                                              m["uid"],
                                              m["nm"],
                                              checkDouble(m["lat"]),
                                              checkDouble(m["lng"])
                                          );

                                          if (fav != null && fav.contains(m["uid"]))
                                            favList.add(shop);
                                        });


                                        print("outside foreah favList = ${favList.length} sList = ${sList.length}");

                                        return Container(
                                          height: 100,
                                          child: favList.length >= 0
                                              ? ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: favList.length,
                                            itemBuilder: (context, index) {
                                              final item1 = favList[index];
                                              print("favList length = ${favList.length}");

                                              return FutureBuilder(
                                                future: FirebaseStorage.instance.ref().child("vendors/${item1.uid}/logo.jpg").getDownloadURL(),
                                                builder: (context, abc) {
                                                  if (abc.hasData) {
                                                    print("add = vendors/${item1
                                                        .uid}/logo.jpg");
                                                    print("url = ${abc.data}");
                                                    String url = abc.data;

                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushReplacement(context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Services(
                                                                        cat, customer,
                                                                        item1, fav,
                                                                        vendor)));
                                                      },
                                                      child: Column(
                                                          children: [
                                                            ClipRRect(
                                                              child: Image.network(url,
                                                                width: 70,
                                                                height: 70,),
                                                              borderRadius: BorderRadius
                                                                  .circular(15),
                                                            ),
                                                            SizedBox(height: 5,),
                                                            if(item1.name.length > 8)
                                                              Text("${item1.name.substring(0, 4)}...")
                                                            else
                                                              Text(item1.name),
                                                          ]
                                                      ),
                                                    );
                                                  }
                                                  return Image(
                                                      image: AssetImage(
                                                        'ASSETS/${cat}.png',
                                                      ),
                                                      fit: BoxFit.cover);
                                                },
                                              );
                                            },
                                          )
                                              : Text("No Favourites has been set yet! ", style: TextStyle(color: Colors.orange),),

                                        );

                                      }else{
                                        return Center(
                                          child: Text("No Favourites has been set yet!", style: TextStyle(color: Colors.orange),),
                                        );
                                      }
                                    }

                                    return Center(
                                      child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(HexColor("#f9692d")),),
                                    );
                                  }
                              ),


                              SizedBox(
                                height: 10,
                              ),
                              Text("Choose From Our Partners"),

                              SizedBox(
                                height: 20,
                              ),

                              FutureBuilder(
                                  future: ref.once(),
                                  builder :(context, data) {
                                    if(data.hasData)  {
                                      DataSnapshot ds = data.data;

                                      if(sList.length > 0)
                                        sList.clear();

                                      if(ds.value != null) {
                                        Map<String, dynamic> values = new Map<String, dynamic>.from(ds.value);
                                        values.forEach((key, val) {
                                          Map <String, dynamic> m = new Map<
                                              String,
                                              dynamic>.from(val);
                                          Shop shop = new Shop(
                                              m["uid"],
                                              m["nm"],
                                              checkDouble(m["lat"]),
                                              checkDouble(m["lng"])
                                          );

                                          if (_currentPosition != null &&
                                              shop.lat != 0) {
                                            String dist_url =
                                                "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${_currentPosition
                                                .latitude},${_currentPosition
                                                .longitude}&destinations=${shop
                                                .lat},${shop
                                                .lng}&key=AIzaSyD7WpJP8mLh6RsvUDPZj4bzsRSeE9roYXc";
                                            shop.dist = dist_url;
                                          }
                                          if (fav != null && fav.contains(m["uid"]))
                                            shop.fav = true;
                                          else
                                            shop.fav = false;

                                          sList.add(shop);
                                        });

                                        print("outside foreah sList = ${sList.length}");

                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: sList.length,
                                            itemBuilder: (context, index) {
                                              final item1 = sList[index];

                                              return GestureDetector(
                                                  onTap: () {
                                                    Navigator.pushReplacement(context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Services(
                                                                    cat, customer,
                                                                    item1, fav,
                                                                    vendor)));
                                                  },

                                                  child: Card( //////              <-- Card widget
                                                    child: ListTile(
                                                      contentPadding: const EdgeInsets
                                                          .all(10.0),

                                                      leading: FutureBuilder(
                                                        future: FirebaseStorage.instance.ref().child("vendors/${item1.uid}/logo.jpg").getDownloadURL(),
                                                        builder: (context, abc) {
                                                          if (abc.hasData) {
                                                            print("add = vendors/${item1.uid}/logo.jpg");
                                                            print("url = ${abc.data}");
                                                            String url = abc.data;

                                                            return ClipRRect(
                                                              borderRadius: BorderRadius.circular(250),
                                                              child: Image.network(url),
                                                            );
                                                          }
                                                          return Image(
                                                              image: AssetImage(
                                                                'ASSETS/${cat}s.png',
                                                              ),
                                                              fit: BoxFit.cover);
                                                        },
                                                      ),

                                                      title: Text(item1.name),

                                                      subtitle: item1.dist != null
                                                          ? FutureBuilder(
                                                        future: Dio().get(item1.dist),
                                                        builder: (context, res) {
                                                          if (res.hasData) {
                                                            Response response = res.data;
                                                            print(" response = $response");
                                                            DistanceMatrix dm = new DistanceMatrix.fromJson(response.data);
                                                            return Text("${dm.elements[0].distance.text} away");
                                                          }
                                                          return Text("");
                                                        },
                                                      )
                                                          : Text(" "),

                                                      trailing: IconButton(
                                                        icon: item1.fav
                                                            ? Icon(Icons.favorite, color: Colors.red,)
                                                            : Icon(
                                                          Icons.favorite_border,),
                                                        iconSize: 30,
                                                        color: Colors.black,
                                                        splashColor: Colors.purple,
                                                        onPressed: () {
                                                          print("onpressed fav");
                                                          if (!item1.fav && fav == null)
                                                            fav = item1.uid + ",$cat;";
                                                          else if (!item1.fav)
                                                            fav += item1.uid + ",$cat;";
                                                          else
                                                            fav.replaceFirst(
                                                                "${item1.uid},$cat;",
                                                                "");

                                                          setState(() {
                                                            item1.fav = !item1.fav;
                                                            FirebaseDatabase.instance
                                                                .reference().child(
                                                                "customers/${customer
                                                                    .uid}/fav").set(fav);
                                                            favList.add(item1);
                                                          });

                                                          Fluttertoast.showToast(
                                                              msg: "${item1.name} added to the favourites.\nYou can edit them in favourite section.",
                                                              gravity: ToastGravity.BOTTOM
                                                          );
                                                        },
                                                      ),

                                                    ),

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(15.0),
                                                      side: BorderSide(
                                                        color: Colors.black,
                                                      ),
                                                    ),

                                                  )
                                              );
                                            }
                                        );
                                      }else{
                                        return Center(
                                          child: Text("We're coming soon.", style: TextStyle(color: Colors.orange),),
                                        );
                                      }

                                    }

                                    return Center(
                                      child: Text("We're coming soon.", style: TextStyle(color: Colors.orange),),
                                    );
                                  }
                              ),

                            ]
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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

  static double checkDouble(dynamic value) {
    if (value is String)
      return double.parse(value);
    else if(value is double)
      return value;
    else if (value is int)
      return value.toDouble();
  }

  Image decodeImageFromBase64(String img64){
    Uint8List bytes = base64Decode(img64);
    return Image.memory(bytes,);
  }

  void initializeLists() async {
    ref = FirebaseDatabase.instance.reference().child("det/vendors/${cat}s");
    await Firebase.initializeApp();
  }

  _getCurrentLocation() async{

    print("get location called");
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("lat = ${_currentPosition.latitude} lng = ${_currentPosition.longitude}");
      });
    }).catchError((e) {
      print(e);
    });
  }



}
