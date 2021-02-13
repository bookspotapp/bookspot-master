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
import "package:location/location.dart" as loc;
import "Date.dart";
import "dart:math";
import 'SearchSpot.dart';

class SalonFirst extends StatefulWidget {
  Customer customer;
  String favList, cat;
  List<Shop> vendorsList;

  SalonFirst(this.cat, this.customer, this.favList, this.vendorsList);

  @override
  _SalonFirstState createState() => _SalonFirstState(customer, favList, cat, vendorsList);
}

class _SalonFirstState extends State<SalonFirst> {

  Customer customer;
  List<Shop> vendorsList;
  List<Shop> favList = [];
  String fav = "";
  String cat;
  Position _currentPosition;
  Vendor vendor;
  bool isfav = false;
  DatabaseReference ref;
  Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  loc.Location location = loc.Location();

  _SalonFirstState(this.customer, this.fav, this.cat, this.vendorsList);

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentLocation();
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


      body:   vendorsList != null && vendorsList.length > 0
          ? Form(
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

                        (fav == null || fav.length < 10 || favList == null || favList.length == 0)
                            ? Text("No Favourites has been set yet! ", style: TextStyle(color: Colors.orange),)
                            : Container(
                          height: 100,
                          child:  ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: favList.length,
                            itemBuilder: (context, index) {
                              final item1 = favList[index];
                              print("favList length = ${favList.length}");
                              return FutureBuilder(
                                future: FirebaseStorage.instance.ref()
                                    .child("vendors/${item1.uid}/logo.jpg")
                                    .getDownloadURL(),
                                builder: (context, abc) {
                                  if (abc.hasData) {
                                    print("add = vendors/${item1.uid}/logo.jpg");
                                    print("url = ${abc.data}");
                                    String url = "${abc.data}";

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) => Services(cat, customer,item1, fav, vendor)
                                            ));
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
                                        cat.compareTo("Gym & Turf") == 0
                                        ? 'ASSETS/${cat.split("")[0]}.png'
                                        : 'ASSETS/${cat}s.png',
                                      ),
                                      fit: BoxFit.cover);
                                },
                              );
                            },
                          ),
                        ),


                        SizedBox(
                          height: 10,
                        ),
                        Text("Choose From Our Partners"),

                        SizedBox(
                          height: 20,
                        ),

                        if(vendorsList.length > 0 && vendorsList[0].distInKm == null)
                          Center(
                            child: Text(
                              "We're coming soon.",
                              style: TextStyle(color: Colors.orange),),
                          )
                        else if(vendorsList.length > 0 && vendorsList[0].uid.compareTo("x") != 0)
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: vendorsList.length,
                              itemBuilder: (context, index) {
                                final item1 = vendorsList[index];

                                return GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Services(cat, customer, item1, fav, vendor)
                                          ));
                                    },

                                    child: Card( //////              <-- Card widget
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.all(10.0),

                                        leading: FutureBuilder(
                                          future: FirebaseStorage.instance.ref().child("vendors/${item1.uid}/logo.jpg").getDownloadURL(),
                                          builder: (context, abc) {
                                            if (abc.hasData) {
                                              print("add = vendors/${item1.uid}/logo.jpg");
                                              print("url = ${abc.data}");
                                              String url = "${abc.data}";

                                              return ClipRRect(
                                                borderRadius: BorderRadius.circular(250),
                                                child: Image.network(url),
                                              );
                                            }
                                            return Image(
                                                image: AssetImage(
                                                  cat.compareTo("Gym & Turf") == 0
                                                      ? 'ASSETS/${cat.split("")[0]}.png'
                                                      : 'ASSETS/${cat}s.png',
                                                ),
                                                fit: BoxFit.cover);
                                          },
                                        ),

                                        title: Text(item1.name),

                                        subtitle: /*item1.dist != null
                                            ? FutureBuilder(
                                          future: Dio().get(item1.dist),
                                          builder: (context, res) {
                                            if (res.hasData) {
                                              Response response = res.data;
                                              print(" response = $response");
                                              DistanceMatrix dm = new DistanceMatrix.fromJson(response.data);
                                              return Text("${(dm.elements[0].distance.value)/10}km away");
                                            }
                                            return Text("");
                                          },
                                        )
                                            : Text(" "),
                                            */
                                        Text("${(item1.distInKm).toStringAsFixed(2)} km away"),

                                        trailing: IconButton(
                                          icon: item1.fav
                                              ? Icon(Icons.favorite, color: Colors.red,)
                                              : Icon(Icons.favorite_border,),
                                          iconSize: 30,
                                          color: Colors.black,
                                          splashColor: Colors.orange[800],
                                          onPressed: () {
                                            print("onpressed fav");
                                            if (!item1.fav && fav == null){
                                              Fluttertoast.showToast(
                                                  msg: "${item1.name} added to the favourites.\nYou can edit them in favourite section.",
                                                  gravity: ToastGravity.BOTTOM
                                              );
                                              setState((){
                                                fav = item1.uid + ",$cat;";
                                              });
                                            }else if (!item1.fav){
                                              Fluttertoast.showToast(
                                                  msg: "${item1.name} added to the favourites.\nYou can edit them in favourite section.",
                                                  gravity: ToastGravity.BOTTOM
                                              );
                                              setState((){
                                                fav += item1.uid + ",$cat;";
                                              });
                                            } else{
                                              Fluttertoast.showToast(
                                                  msg: "${item1.name} removed from the favourites.",
                                                  gravity: ToastGravity.BOTTOM
                                              );
                                              setState(() {
                                                fav = fav.replaceFirst("${item1.uid},$cat;", "");
                                              });
                                            }

                                            setState(() {
                                              item1.fav = !item1.fav;
                                              FirebaseDatabase.instance.reference().child("customers/${customer.uid}/fav").set(fav);favList.add(item1);
                                            });


                                          },
                                        ),

                                      ),

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                        side: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),

                                    )
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
      )
          : Center(
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),),
      ),
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

    if(vendorsList == null){
      DataSnapshot ds = await ref.once();

      vendorsList = new List();

      if (ds.value != null) {
        Map<String, dynamic> values = new Map<String, dynamic>.from(ds.value);

        values.forEach((key, val)  async {
          Map <String, dynamic> m = new Map<
              String,
              dynamic>.from(val);

          Shop shop = new Shop(
              m["uid"],
              m["nm"],
              checkDouble(m["lat"]),
              checkDouble(m["lng"])
          );

          if (_currentPosition != null && shop.lat != 0) {
            String dist_url =
                "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${_currentPosition.latitude},"
                "${_currentPosition.longitude}&destinations=${shop.lat},"
                "${shop.lng}&key=AIzaSyD7WpJP8mLh6RsvUDPZj4bzsRSeE9roYXc";

            if (shop.lat != null && shop.lat != 0.0) {
              shop.dist = dist_url;
              shop.distInKm = getDistance(_currentPosition.latitude, _currentPosition.longitude, shop.lat, shop.lng);
              print("${shop.name} dist = ${shop.distInKm}");
            } else {
              shop.distInKm = -1.0;
            }

            if(shop.distInKm != -1.0 && shop.distInKm <= 100){
              if (fav != null && fav.contains(m["uid"])) {
                shop.fav = true;
                favList.add(shop);
                print("shop name ${shop.name} is added to favList");
              } else
                shop.fav = false;

              print("shop name ${shop.name} is added to vendorsList");

              vendorsList.add(shop);
            }else
              print("shop name = ${shop.name} is not added");

          }

        });

        if (vendorsList.length == 0) {
          print("length = ${vendorsList.length}");

            Shop shop = new Shop("x", "y", 0.0, 0.0);
            vendorsList.add(shop);
            print("length after adding xy = ${vendorsList.length}");
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => SalonFirst(cat, customer, fav, vendorsList))
            );

        } else if(vendorsList.length > 0){
          print("length = ${vendorsList.length}");
          vendorsList.sort((a,b) => a.distInKm.compareTo(b.distInKm));
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder:  (context) => SalonFirst(cat, customer, fav, vendorsList)
          ));
        }

      }else {
        vendorsList = new List();
        vendorsList.add(new Shop("X", "Y", 0.0, 0.0));
        print("length after adding xy = ${vendorsList.length}");
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => SalonFirst(cat, customer, fav, vendorsList))
        );
      }
    }
  }

  _getCurrentLocation() async{
    print("get location called");
    bool gps = await location.requestService();
    if(gps) {
      await geolocator
          .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation)
          .then((Position position) {
        setState(() {
          _currentPosition = position;
          print("lat = ${_currentPosition.latitude} lng = ${_currentPosition
              .longitude}");
          initializeLists();
        });
      }).catchError((e) {
        print(e);
      });
    }else
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomePage(customer),
      ));
  }

  getDistance(double lt1, double ln1, double lt2, double ln2){
    double lat1, lat2, lon1, lon2;

    if(lt1 > lt2){
      lat2 = lt1;
      lat1 = lt2;
    }else{
      lat2 = lt2;
      lat1 = lt1;
    }

    if(ln1 > ln2){
      lon2 = ln1;
      lon1 = ln2;
    }else{
      lon2 = ln2;
      lon1 = ln1;
    }

    double p = 3.14/180;
    double a = 0.5 - cos((lat2-lat1)*p)/2 + cos(lat1*p) * cos(lat2*p) * (1-cos((lon2-lon1)*p))/2;
    return 12742 * asin(sqrt(a));
  }


}
