import 'package:bookspot/homepage.dart';
import 'package:bookspot/loginpage.dart';
import 'package:bookspot/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';

class OTpSc extends StatefulWidget {
  @override
  _OTpScState createState() => _OTpScState();
}

class _OTpScState extends State<OTpSc> {

  TextEditingController otpController = new TextEditingController();
  String verId = "";
  String uid = "";
  FirebaseAuth _auth;

  @override
  void initState()  {
    sendOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: Image(
                image: AssetImage("ASSETS/logo.png"),
              ),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 50, right: 210),
                            child: Text(
                              "Enter OTP",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
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
                              hintText: 'Enter OTP',
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: otpController,
                            onSaved: (String val) {
                              number = val;
                            },
                          ),
                          SizedBox(
                            height: 310,
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
                              "verify",
                              style: TextStyle(color: Colors.white, fontSize: 20.0),
                            ),
                            onPressed: () {
                              _signInWithPhoneNumber(otpController.text.trim());
                            },
                            splashColor: Colors.redAccent,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
        )
    );
  }

  void sendOTP() async {
    await Firebase.initializeApp();

    _auth = FirebaseAuth.instance;
    SharedPreferences preferences = await SharedPreferences.getInstance() ;

    _auth.verifyPhoneNumber(
        phoneNumber: number,

        timeout: Duration(seconds: 60),


        verificationCompleted: (PhoneAuthCredential authCredential)  {
          _auth.signInWithCredential(authCredential);

          if(_auth.currentUser != null){
              preferences.setBool("logged", true);
              preferences.setString("cno", number);
              preferences.setString("uid", _auth.currentUser.uid);
              preferences.setString("name", name);

              customer.cno = number;
              customer.uid = _auth.currentUser.uid;
              customer.nm = name;

              uid = _auth.currentUser.uid;

              DatabaseReference ref =  FirebaseDatabase.instance.reference().child("customers");
              ref.child(customer.uid).set(<String, Object>{
                "nm" : customer.nm,
                "uid" : uid,
                "cno" : customer.cno
              });

              print("name = ${customer.nm}");
              print("uid = ${customer.uid}");
              print("cno = ${customer.cno}");

              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => HomePage(customer)
              ));

              Fluttertoast.showToast(msg: "Login Successfull!",
                  backgroundColor: HexColor("#f9692d"),
                  textColor: Colors.white,
                  timeInSecForIosWeb: 2,
                  gravity: ToastGravity.BOTTOM);

            }
          else
            print("curruser = null");
          }, //Verification Completed

        verificationFailed: (FirebaseAuthException authException){
          Fluttertoast.showToast(msg: authException.message,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              timeInSecForIosWeb: 2,
              gravity: ToastGravity.BOTTOM);
        },// Verification Failed

        codeSent: (String verificationId, [int forceResendingToken]){
          verId = verificationId;
        },// Verification Code Sent

        codeAutoRetrievalTimeout: (String verificationId){

          Fluttertoast.showToast(msg: "Verification Timeout",
              textColor: Colors.white,
              timeInSecForIosWeb: 2,
              gravity: ToastGravity.BOTTOM);

          Navigator.pop(context);// finishing the activity

        }
    );
  }// sendOTP

  void verifyCode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance() ;

    if(verId.compareTo(otpController.text.toString()) == 0){

      Fluttertoast.showToast(msg: "Login Successfull!",
          backgroundColor: HexColor("#f9692d"),
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          gravity: ToastGravity.CENTER);

      preferences.setBool("logged", true);
      preferences.setString("name", name);
      preferences.setString("uid", uid);
      preferences.setString("cno", number);

      customer.cno = number;
      customer.uid = uid;
      customer.nm = name;

      DatabaseReference ref = FirebaseDatabase.instance.reference().child("customers");
      ref.child(customer.uid).set({
        "nm" : customer.nm,
        "uid" : uid,
        "cno" : customer.cno
      });

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage(customer)
      ));

    }
  }



  void _signInWithPhoneNumber(String smsCode) async {
    AuthCredential _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);

    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    _auth.signInWithCredential(_authCredential);

      if(_auth.currentUser != null){
        preferences.setBool("logged", true);
        preferences.setString("cno", number);
        preferences.setString("uid", _auth.currentUser.uid);
        preferences.setString("name", name);

        customer.cno = number;
        customer.uid = _auth.currentUser.uid;
        customer.nm = name;

        uid = _auth.currentUser.uid;

        DatabaseReference ref =  FirebaseDatabase.instance.reference().child("customers");
        ref.child(customer.uid).set(<String, Object>{
          "nm" : customer.nm,
          "uid" : uid,
          "cno" : customer.cno
        });

        print("name = ${customer.nm}");
        print("uid = ${customer.uid}");
        print("cno = ${customer.cno}");

        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomePage(customer)
        ));

        Fluttertoast.showToast(msg: "Login Successfull!",
            backgroundColor: HexColor("#f9692d"),
            textColor: Colors.white,
            timeInSecForIosWeb: 2,
            gravity: ToastGravity.BOTTOM);

      }
      else
        print("curruser = null");


  }

}//_OTpScState