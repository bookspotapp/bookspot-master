import 'package:bookspot/ContainerClass.dart';
import 'package:bookspot/history.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/profile.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'homepage.dart';

class Favorites extends StatefulWidget {
  Customer customer;

  Favorites(this.customer);

  @override
  _FavoritesState createState() => _FavoritesState(customer);
}

class _FavoritesState extends State<Favorites> {
  Customer customer;
  String fav;

  _FavoritesState(this.customer);

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

            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
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
                      "Favourites",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),

                FutureBuilder(
                  future: FirebaseDatabase.instance.reference().child("customers/${customer.uid}/fav").once(),
                  builder: (context, data){
                    if(data.hasData){

                      DataSnapshot ds = data.data;
                      fav = ds.value;
                      if(fav == null || fav.compareTo("") == 0)
                        return Center(child: Text("No favourites has been selected yet!", style: TextStyle(fontSize: 20,color: HexColor("#f9692d ")),),);

                      List<String> favList = fav.split(";");

                      print("favLst = $favList");

                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: favList.length,
                          itemBuilder: (context, index){
                            List<String> favDet = favList[index].split(",");
                            if(favDet.length == 2) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black, width: 2),
                                ),
                                shadowColor: Colors.black,
                                elevation: 10,
                                child: Container(
                                  height: 130,
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 30,),
                                          Text("Place Name   :"),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          FutureBuilder(
                                            future: FirebaseDatabase.instance
                                                .reference().child(
                                                "vendors/${favDet[0]}/fname").once(),
                                            builder: (context, data) {
                                              if (data.hasData) {
                                                DataSnapshot ds = data.data;
                                                String name = ds.value;
                                                return Text(name);
                                              }
                                              return Text("");
                                            },
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(width: 30,),
                                          Text("Category   :"),
                                          SizedBox(
                                            width: 100,
                                          ),
                                          Text(favDet[1]),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Fluttertoast.showToast(msg: "deleted!", gravity: ToastGravity.BOTTOM);
                                          favList.removeAt(index);
                                          print("index = $index");
                                          print("favList = $favList");
                                          print("deleting =${favDet[0]},${favDet[1]};");
                                          String newFav = fav.replaceAll("${favDet[0]},${favDet[1]};", '');
                                          print("fav after deletion = $newFav");
                                          FirebaseDatabase.instance.reference().child("customers/${customer.uid}/fav").set(newFav);
                                          setState(() {
                                            favList.removeAt(index);
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.delete),
                                            Text("Remove"),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              );
                            }
                            return Text("");
                          }
                      );
                    }
                    return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>( HexColor("#f9692d ")))) ;
                  },
                )


              ],
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
}
