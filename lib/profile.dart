import 'dart:io';

import 'package:bookspot/favorites.dart';
import 'package:bookspot/history.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContainerClass.dart';
import 'homepage.dart';

class ProfileSetting extends StatefulWidget {
  Customer customer;

  ProfileSetting(this.customer);

  @override
  _ProfileSettingState createState() => _ProfileSettingState(customer);
}

class _ProfileSettingState extends State<ProfileSetting> {
  File _image;
  bool buttonVisibility = true, progressVisibility = false;
  Customer customer;
  SharedPreferences preferences;
  TextEditingController nameController = new TextEditingController(), cnoController = new TextEditingController(), emailController = new TextEditingController();

  _ProfileSettingState(this.customer);

  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initializeFirebase();
    if(customer.nm != null)
      nameController.text = customer.nm;
    if(customer.email != null)
      emailController.text = customer.email;
    if(customer.cno != null)
      cnoController.text = customer.cno;
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Center(
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
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) => HomePage(customer)
                                    ));
                                  },
                                ),
                                Text(
                                  "Profile Settings",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundColor: Colors.grey[200],
                                child:  _image != null
                                ? ClipRRect(
                                  child: Image.file(_image),
                                  borderRadius: BorderRadius.circular(250.0),
                                )
                                : FutureBuilder(
                                        future: FirebaseStorage.instance.ref().child("customers/${customer.uid}/profile.png").getDownloadURL(),
                                        builder:(context, data){
                                          if(data.hasData){
                                            String url = data.data;
                                            return  ClipRRect(
                                              child: Image.network(url),
                                              borderRadius: BorderRadius.circular(250.0),
                                            );
                                          }

                                          return   GestureDetector(
                                            onTap: () {
                                              getImage();
                                            },
                                            child: _image != null
                                              ? ClipRRect(
                                                  child: Image.file(_image),
                                                  borderRadius: BorderRadius.circular(250.0),
                                                )
                                                :  Image.asset(
                                                      'ASSETS/camera.png',
                                                      width: 40,
                                                      height: 40,
                                                      fit: BoxFit.fill,
                                                    ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Text(
                                "Edit Photo",
                                style: TextStyle(color: Colors.orange[800]),
                              ),
                            ),

                            SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Full Name',
                                prefixIcon: Icon(Icons.person),
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                ),
                              ),

                              controller: nameController,
                              keyboardType: TextInputType.text,
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
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                autovalidate: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter valid Email address';
                                  }
                                  return null;
                                }
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
                                  hintText: 'Phone Number',
                                  prefixIcon: Icon(Icons.phone),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                controller: cnoController,
                                autovalidate: true,
                                validator: (value) {
                                  if (value.isEmpty || value.length < 10) {
                                    return 'Enter valid Phone No.';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 80,
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
                                    "Save Details",
                                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                                  ),
                                  onPressed: () async {
                                    if(nameController.text.trim().isNotEmpty && cnoController.text.trim().isNotEmpty && emailController.text.trim().isNotEmpty ) {

                                      setState((){
                                        buttonVisibility = false;
                                        progressVisibility = true;
                                      });

                                      preferences.setString("nm", nameController.text);
                                      preferences.setString("cno", cnoController.text);
                                      preferences.setString("email", emailController.text);

                                      customer.nm = nameController.text;
                                      customer.email = emailController.text;
                                      customer.cno = cnoController.text;

                                      FirebaseDatabase.instance.reference().child("customers/${customer.uid}/nm").set(nameController.text);
                                      FirebaseDatabase.instance.reference().child("customers/${customer.uid}/cno").set(cnoController.text);
                                      FirebaseDatabase.instance.reference().child("customers/${customer.uid}/email").set(emailController.text);
                                      StorageReference storageReference = FirebaseStorage.instance.ref().child('customers/${customer.uid}/profile.png');
                                      StorageUploadTask uploadTask = storageReference.putFile(_image);
                                      await uploadTask.onComplete;
                                      Fluttertoast.showToast(msg: "Details Saved!",
                                          textColor: Colors.white,
                                          timeInSecForIosWeb: 2,
                                          gravity: ToastGravity.BOTTOM);

                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(
                                          builder: (context) => HomePage(customer)));
                                    }
                                  },
                                  splashColor: Colors.redAccent,
                                )
                            ),

                            Visibility(
                              visible: progressVisibility,
                              child:  CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    preferences = await SharedPreferences.getInstance();
  }
}
