import 'package:bookspot/salon/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';
import "dart:math";

import '../ContainerClass.dart';

class SearchSpot extends StatefulWidget {

  Customer customer;
  String favList, cat;

  SearchSpot(this.customer, this.favList, this.cat);

  @override
  _SearchSpot createState() => _SearchSpot(customer, favList, cat);
}

class _SearchSpot extends State<SearchSpot> {

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
  SearchBarController<Shop> _searchBarController = new SearchBarController();


  _SearchSpot(this.customer, this.fav, this.cat);

  @override
  void initState() {
    // TODO: implement initState
    initializeLists();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: Image(
              image: AssetImage("ASSETS/logo.png"),
            ),
            backgroundColor: HexColor("#f9692d"),
            elevation: 0.0,
          ),

          body: SearchBar<Shop>(
            searchBarStyle: SearchBarStyle(
              borderRadius: BorderRadius.circular(40),
            ),
            searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
            headerPadding: EdgeInsets.symmetric(horizontal: 10),
            listPadding: EdgeInsets.symmetric(horizontal: 10),
            onSearch: _getALlShops,
            searchBarController: _searchBarController,
            placeHolder: Center(child : Text("Enter atleast 3 alphabets to search")),
            cancellationWidget: Text("Cancel"),
            emptyWidget: Center(
                child : Text(
                  "Enter atleast 3 alphabets to search",
                  style: TextStyle(
                      color: Colors.orange
                  ),
                )
            ),
            hintText: cat != null ? "Search a $cat" : "Search a Spot",
            indexedScaledTileBuilder: (int index) => ScaledTile.count(2,0.3),
            onCancelled: () {
              print("Cancelled triggered");
              Navigator.of(context).pop();
            },
            onError: (error){
              print("error = $error");
              return  Center(
                child: Text(
                  "Nothing to Show...",
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              );
            },
            iconActiveColor: Colors.orange,
            onItemFound: (Shop item1, int index){

              return GestureDetector(
                  onTap:  () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (context) => Services(cat, customer, item1, fav, vendor)) );
                  },

                  child :Card( //////              <-- Card widget
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),

                      leading : FutureBuilder(
                        future: FirebaseStorage.instance.ref().child("vendors/${item1.uid}/logo.jpg").getDownloadURL(),
                        builder: (context, abc){
                          if(abc.hasData) {
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
                                cat == null
                                    ? 'Salons.png'
                                    : '${cat}s.png',
                              ),
                              fit: BoxFit.cover
                          );
                        },
                      ),

                      title: Text(item1.name),

                      subtitle: item1.distInKm != -1
                          ? /*FutureBuilder(
                        future: Dio().get(item1.dist),
                        builder: (context, res){
                          if(res.hasData){
                            Response response = res.data;
                            print(" response = $response");
                            DistanceMatrix dm = new DistanceMatrix.fromJson(response.data);
                            return Text("${dm.elements[0].distance.text} away");
                          }
                          return Text("");
                        },
                      )
                      */  Text("${(item1.distInKm).toStringAsFixed(2)} km away")
                          : Text(" "),

                      trailing:  IconButton(
                        icon: item1.fav
                            ? Icon(Icons.favorite, color: Colors.red,)
                            : Icon(Icons.favorite_border,),
                        iconSize: 30,
                        color: Colors.black,
                        splashColor: Colors.purple,
                        onPressed: (){
                          print("onpressed fav");
                          if(!item1.fav && fav == null)
                            fav = item1.uid + ",$cat;";
                          else if(!item1.fav)
                            fav += item1.uid + ",$cat;";
                          else
                            fav.replaceFirst("${item1.uid},$cat;", "");

                          FirebaseDatabase.instance.reference().child("customers/${customer.uid}/fav").set(fav);

                          Fluttertoast.showToast(
                              msg: "${item1.name} added to the favourites.\nYou can edit them in favourite section.",
                              gravity: ToastGravity.BOTTOM
                          );

                          setState(() {
                            item1.fav = !item1.fav;
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
            },
          )
      ),
    );
  }

  Future<List<Shop>> _getALlShops(String text) async {

    print("inside _getAllShops");
    List<Shop> sList = [];

    try {
      if (cat != null && cat.isNotEmpty) {
        print("cat is not null = $cat ");

        DataSnapshot ds;
        ds = await FirebaseDatabase.instance.reference()
            .child("det/vendors/${cat}s")
            .once();

        if (sList.length > 0)
          sList.clear();

        if (ds.value != null) {
          Map<String, dynamic> values = new Map<String, dynamic>.from(ds.value);
          values.forEach((key, val) {
            Map <String, dynamic> m = new Map<String, dynamic>.from(val);
            Shop shop = new Shop(
                m["uid"],
                m["nm"],
                checkDouble(m["lat"]),
                checkDouble(m["lng"])
            );

            if (_currentPosition != null && shop.lat != 0) {
              String dist_url =
                  "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${_currentPosition
                  .latitude},${_currentPosition
                  .longitude}&destinations=${shop
                  .lat},${shop
                  .lng}&key=AIzaSyD7WpJP8mLh6RsvUDPZj4bzsRSeE9roYXc";
              shop.dist = dist_url;
              if(shop.lat == 0.0)
                shop.distInKm = -1.0;
              else
                shop.distInKm = getDistance(_currentPosition.latitude, _currentPosition.longitude, shop.lat, shop.lng);
            }
            if (fav != null && fav.contains(m["uid"]))
              shop.fav = true;
            else
              shop.fav = false;

            if (shop.name.toLowerCase().contains(text.toLowerCase())) {
              print("${shop.name} contains ${text} ");
              sList.add(shop);
            } else
              print("${shop.name} does not contain $text");
          });
        }
      }
      else {
        print("cat is null");
        List<String> catList = [
          "Salons",
          "Restraunts",
          "Doctors",
          "Diagnostic Centres",
          "Service Centres",
          "Gyms & Turfs",
          "Banks",
          "Retails",
          "Government Offices"
        ];

        if (sList.length > 0)
          sList.clear();

        for (int i = 0; i < catList.length; i++) {
          DataSnapshot ds = await FirebaseDatabase.instance.reference().child(
              "det/vendors/${catList[i]}").once();

          if (ds.value != null) {
            Map<String, dynamic> values = new Map<String, dynamic>.from(
                ds.value);
            values.forEach((key, val) {
              Map <String, dynamic> m = new Map<String, dynamic>.from(val);
              Shop shop = new Shop(
                  m["uid"],
                  m["nm"],
                  checkDouble(m["lat"]),
                  checkDouble(m["lng"])
              );

              if (_currentPosition != null && shop.lat != 0) {
                String dist_url =
                    "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${_currentPosition
                    .latitude},"
                    "${_currentPosition.longitude}&destinations=${shop.lat},"
                    "${shop.lng}&key=AIzaSyD7WpJP8mLh6RsvUDPZj4bzsRSeE9roYXc";
                shop.dist = dist_url;
                if(shop.lat == 0.0)
                  shop.distInKm = -1.0;
                else
                  shop.distInKm = getDistance(_currentPosition.latitude, _currentPosition.longitude, shop.lat, shop.lng);
              }
              if (fav != null && fav.contains(m["uid"]))
                shop.fav = true;
              else
                shop.fav = false;


              if (shop.name.toLowerCase().contains(text.toLowerCase())) {
                print("${shop.name} contains ${text} ");
                sList.add(shop);
                print("slist length = ${sList.length}");
              }
            });
          }
        }

        print("slist length outside for = ${sList.length}");
      }
    }on FormatException catch(e){
      print("exception = $e");
    }
    if(sList.length == 0)
      return null;

    sList.sort((a,b) => a.distInKm.compareTo(b.distInKm));

    return sList;
  }

  void initializeLists() async {
    _getCurrentLocation();
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

  static double checkDouble(dynamic value) {
    if (value is String){
      double d = double.tryParse(value);
      if( d == null)
        return 0.0;
      else
        return d;
    }else if(value is double)
      return value;
    else if (value is int)
      return value.toDouble();
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
