
import 'package:firebase_database/firebase_database.dart';

class Customer{
  String uid ;
  String nm;
  String cno;

  Customer(){}
}

class OrderDetails{
  String uid;
  String cno;
  String bTime;
  String Stype;
  String nm;
  int tkn;
  int sbk;

  OrderDetails(
      this.uid, this.cno, this.bTime, this.Stype, this.nm, this.tkn, this.sbk);

  @override
  String toString() {
    return '$uid,$cno,$bTime,$Stype,$nm,$tkn,$sbk';
  }

}

class Shop{
  String uid;
  String name;
  double lat;
  double lng;

  Shop(this.uid, this.name, this.lat, this.lng);
}