import 'package:bookspot/ContainerClass.dart';
import 'package:bookspot/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class Introduction extends StatefulWidget{
  @override
  _IntroductionState createState() => _IntroductionState();
}


class _IntroductionState extends State<Introduction>{
  Customer customer;
  double height, width;

  Future<void> _onIntroEnd(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("second", true);
    if(preferences.getBool("logged") == null) {
      print("null ");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print("not null");
      bool login = preferences.getBool("logged");
      if(login){
        customer = new Customer();
        customer.nm = preferences.getString("name");
        customer.uid = preferences.getString("uid");
        customer.cno = preferences.getString("cno");
        customer.email = preferences.getString("email");

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage(customer)));
      }else{

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    const bodyStyle = TextStyle(fontSize: 19.0,);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Step 1 :-",
          body: "Choose Your Category",
          image: Image(
            image: AssetImage("ASSETS/1.png"),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Step 2 :-",
          body: "Find your Store.",
          image: Image(
            image: AssetImage("ASSETS/2.png"),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Step 3 :-",
          body: "Schedule date, time & service",
          image: Image(
            image: AssetImage("ASSETS/3.png"),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Step 4 :-",
          body: "Sit back, and relax!",
          image: Image(
            image: AssetImage("ASSETS/4.png"),
          ),
          decoration: pageDecoration,
        ),

      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
