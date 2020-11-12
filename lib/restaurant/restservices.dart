import 'package:bookspot/favorites.dart';
import 'package:bookspot/privacy.dart';
import 'package:bookspot/restaurant/firstres.dart';
import 'package:bookspot/restaurant/restconferm.dart';
import 'package:bookspot/salon/Date.dart';
import 'package:bookspot/settings.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RestServices extends StatefulWidget {
  @override
  _RestServicesState createState() => _RestServicesState();
}

class _RestServicesState extends State<RestServices> {
  int _value = 1;
  int _itemCount = 0;
  String _number;
  bool isButtonPressed = false;
  bool isButtonPressed1 = false;
  bool isButtonPressed2 = false;
  bool isButtonPressed3 = false;
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
            SingleChildScrollView(
              child: Padding(
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
                          splashColor: Colors.purple,
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RestorFirst()));
                          },
                        ),
                      ),
                      Container(
                        height: 100,
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
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Salon Name:"),
                                SizedBox(
                                  width: 130,
                                ),
                                Text("A B C D"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Address:"),
                                SizedBox(
                                  width: 150,
                                ),
                                Text("1 2 3 4 5"),
                              ],
                            ),
                            SizedBox(
                              height: 10,
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
                              child: DropdownButton(
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Choose Services"),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Second Item"),
                                      value: 2,
                                    ),
                                    DropdownMenuItem(
                                        child: Text("Third Item"), value: 3),
                                    DropdownMenuItem(
                                        child: Text("Fourth Item"), value: 4)
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  }),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Book Table For"),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
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
                        height: 10,
                      ),
                      Text("Book Table For"),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("4"),
                              color: isButtonPressed
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed = !isButtonPressed;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Services()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("6"),
                              color: isButtonPressed1
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed1 = !isButtonPressed1;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Services()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("8"),
                              color: isButtonPressed2
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed2 = !isButtonPressed2;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Services()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.black)),
                              child: Text("More"),
                              color: isButtonPressed3
                                  ? Colors.orange[800]
                                  : Colors.white,
                              onPressed: () {
                                setState(() {
                                  isButtonPressed3 = !isButtonPressed3;
                                });
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Services()));
                              },
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: 'Enter Number',
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                          ),
                          keyboardType: TextInputType.text,
                          onSaved: (String val) {
                            _number = val;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      MaterialButton(
                        height: 52,
                        minWidth: 323,
                        color: Colors.blue[900],
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Text(
                          "Proceed",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfiramationRest()));
                        },
                        splashColor: Colors.redAccent,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
