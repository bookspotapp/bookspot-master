import 'package:bookspot/firstpage.dart';
import 'package:bookspot/forget.dart';
import 'package:bookspot/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Otp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

String number = "";
String name = "";

class _LoginPageState extends State<LoginPage> {

  TextEditingController noCoontroller = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  String Code = "Select Country Code";
  String CountryCode = "";

  List<String> CodeList = [
    "Select Country Code", "+93 Afghanistan", "+355 Albania",
    "+213 Algeria", "+376 Andorra", "+244 Angola", "+672 Antarctica", "+54 Argentina",
    "+374 Armenia", "+297 Aruba", "+61 Australia", "+43 Austria", "+994 Azerbaijan",
    "+973 Bahrain", "+880 Bangladesh", "+375 Belarus", "+32 Belgium", "+501 Belize",
    "+229 Benin", "+975 Bhutan", "+591 Bolivia", "+387 Bosnia And Herzegovina", "+267 Botswana",
    "+55 Brazil", "+673 Brunei Darussalam", "+359 Bulgaria", "+226 Burkina Faso", "+95 Myanmar",
    "+255 Burundi", "+855 Cambodia", "+237 Cameroon", "+1 Canada", "+238 Cape Verde",
    "+236 Central African Republic", "+235 Chad", "+56 Chile", "+86 China", "+61 Christmas Island",
    "+61 Cocos (keeling) Islands", "57 Colombia", "+269 Comoros", "242 Congo", "+682 Cook Islands",
    "+506 Costa Rica", "+385 Croatia", "+53 Cuba", "+357 Cyprus", "+420 Czech Republic",
    "+45 Denmark", "+253 Djibouti", "+670 Timor-leste", "+593 Ecuador", "+20 Egypt",
    "+503 El Salvador", "+240 Equatorial Guinea", "+291 Eritrea", "+372 Estonia", "+251 Ethiopia",
    "+500 Falkland Islands (malvinas)", "+298 Faroe Islands", "+679 Fiji", "+358 Finland", "+33 France",
    "+689 French Polynesia", "+241 Gabon", "+220 Gambia", "+995 Georgia", "+49 Germany",
    "+233 Ghana", "+350 Gibraltar", "+30 Greece", "+299 Greenland", "+502 Guatemala",
    "+224 Guinea", "+245 Guinea-bissau", "+592 Guyana", "+509 Haiti", "+504 Honduras",
    "+852 Hong Kong", "+36 Hungary", "+91 India", "+62 Indonesia", "+98 Iran",
    "+964 Iraq", "+353 Ireland", "+44 Isle Of Man", "+972 Israel", "+39 Italy",
    "+225 Ivory Coast", "+1876 Jamaica", "+81 Japan", "+962 Jordan", "+7 Kazakhstan",
    "+254 Kenya", "+686 Kiribati", "+965 Kuwait", "+996 Kyrgyzstan", "+856 Laos",
    "+371 Latvia", "+961 Lebanon", "+266 Lesotho", "+231 Liberia", "+218 Libya",
    "+423 Liechtenstein", "+370 Lithuania", "+352 Luxembourg", "+853 Macao", "+389 Macedonia",
    "+261 Madagascar", "+265 Malawi", "+60 Malaysia", "+960 Maldives", "+223 Mali",
    "+356 Malta", "+692 Marshall Islands", "+222 Mauritania", "+230 Mauritius", "+262 Mayotte",
    "+52 Mexico", "+691 Micronesia", "+373 Moldova", "+377 Monaco", "+976 Mongolia",
    "+382 Montenegro", "+212 Morocco", "+258 Mozambique", "+264 Namibia", "+674 Nauru",
    "+977 Nepal", "+31 Netherlands", "+687 New Caledonia", "+64 New Zealand", "+505 Nicaragua",
    "+227 Niger", "+234 Nigeria", "+683 Niue", "+850 Korea", "+47 Norway",
    "+968 Oman", "+92 Pakistan", "+680 Palau", "+507 Panama", "+675 Papua New Guinea",
    "+595 Paraguay", "+51 Peru", "+63 Philippines", "+870 Pitcairn", "+48 Poland",
    "+351 Portugal", "+1 Puerto Rico", "+974 Qatar", "+40 Romania", "+7 Russian Federation",
    "+250 Rwanda", "+590 Saint Barthélemy", "+685 Samoa", "+378 San Marino", "+239 Sao Tome And Principe",
    "+966 Saudi Arabia", "+221 Senegal", "+381 Serbia", "+248 Seychelles", "+232 Sierra Leone",
    "+65 Singapore", "+421 Slovakia", "+386 Slovenia", "+677 Solomon Islands", "+252 Somalia",
    "+27 South Africa", "+82 Korea, Republic Of", "+34 Spain", "+94 Sri Lanka", "+290 Saint Helena",
    "+508 Saint Pierre And Miquelon", "+249 Sudan", "+597 Suriname", "+268 Swaziland", "+46 Sweden",
    "+41 Switzerland", "+963 Syrian Arab Republic", "+886 Taiwan", "+992 Tajikistan", "+255 Tanzania",
    "+66 Thailand", "+228 Togo", "+690 Tokelau", "+676 Tonga", "+216 Tunisia",
    "+90 Turkey", "+993 Turkmenistan", "+688 Tuvalu", "+971 United Arab Emirates", "+256 Uganda",
    "+44 United Kingdom", "+380 Ukraine", "+598 Uruguay", "+1 United States", "+998 Uzbekistan",
    "+678 Vanuatu", "+39 Holy See (vatican City State)", "+58 Venezuela", "+84 Viet Nam", "+681 Wallis And Futuna",
    "+967 Yemen", "+260 Zambia", "+263 Zimbabwe"
  ];


  @override
  void initState() {
    // TODO: implement initState
    initializeFirebase();
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

            body: Form(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Login",
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
                                  hintText: 'Name',
                                  prefixIcon: Icon(Icons.account_circle),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                controller: nameController,
                                onSaved: (String val) {
                                  number = val;
                                },
                                autovalidate: true,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Enter Name';
                                  }
                                  return null;
                                }
                            ),
                            SizedBox(
                              height: 40,
                            ),

                          Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  border: Border.all()),
                              child: Center(
                                  child:  DropdownButtonHideUnderline(
                                    child:  DropdownButton<String>(
                                        value: Code,

                                        items: CodeList != null
                                            ? CodeList.map((String value){
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
                                            Code = value;
                                            List<String> s = value.split(" ");
                                            CountryCode = s[0];
                                            print("country code = $CountryCode");
                                          });
                                        }),
                                  ),
                              )
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
                                  hintText: 'Phone number',
                                  prefixIcon: Icon(Icons.phone),
                                  contentPadding: const EdgeInsets.only(
                                      left: 14.0, bottom: 8.0, top: 8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                controller: noCoontroller,
                                onSaved: (String val) {
                                  number = val;
                                },
                                autovalidate: true,
                                validator: (value) {
                                  if (value.isEmpty || value.length != 10) {
                                    return 'Enter valid Phone No.';
                                  }
                                  return null;
                                }
                            ),


                            SizedBox(
                              height: 150,
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
                                "Send OTP",
                                style: TextStyle(color: Colors.white, fontSize: 20.0),
                              ),
                              onPressed: () {
                                number = CountryCode + noCoontroller.text.trim();
                                name = nameController.text.trim();

                                print("name = $name no = $number");

                                if(CountryCode.isEmpty){
                                  Fluttertoast.showToast(msg: "Please! Select your Country Code", gravity: ToastGravity.BOTTOM);
                                }
                                if(CountryCode.compareTo("Select Country Code") != 0 && name.isNotEmpty && number.isNotEmpty && number.length > 10){
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => OTpSc())
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
                )),
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

  void initializeFirebase() async {
    await Firebase.initializeApp();
  }
}
