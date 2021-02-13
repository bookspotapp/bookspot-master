class Customer{
  String uid ;
  String nm;
  String cno, email;

  Customer();
}

class OrderDetails{
  String uid;
  String cno;
  String bTime;
  String bDate;
  String Stype;
  String nm;
  bool com;
  int sbk;
  OrderDetails(
      this.uid, this.cno, this.Stype, this.nm, this.com, this.sbk);

  @override
  String toString() {
    return '$uid,$cno,$bTime,$bDate,$Stype,$nm,$com,$sbk';
  }

}

class Order{
  String fname, Stype, dt, tm, vid;
  int st;

  Order(this.fname, this.Stype, this.dt, this.tm, this.vid, this.st);
}

class Shop{
  String uid;
  String name;
  double lat;
  double lng;
  double distInKm;
  String dist;
  bool fav;

  Shop(this.uid, this.name, this.lat, this.lng);
}

class Vendor{
  String cno, fname, oname, add, email, website, addno, cat, services, total_tokens, sdate, stime, UID, rat, ltiming, op;
  double lat, lng;

  Vendor(
      this.cno,
      this.fname,
      this.oname,
      this.add,
      this.email,
      this.website,
      this.addno,
      this.cat,
      this.services,
      this.total_tokens,
      this.sdate,
      this.stime,
      this.UID,
      this.rat,
      this.ltiming,
      this.lat,
      this.lng,
      this.op);
}


class DistanceMatrix {
  final List<String> destinations;
  final List<String> origins;
  final List<Element> elements;
  final String status;

  DistanceMatrix({this.destinations, this.origins, this.elements, this.status});

  factory DistanceMatrix.fromJson(Map<String, dynamic> json) {
    var destinationsJson = json['destination_addresses'];
    var originsJson = json['origin_addresses'];
    var rowsJson = json['rows'][0]['elements'] as List;

    return DistanceMatrix(
        destinations: destinationsJson.cast<String>(),
        origins: originsJson.cast<String>(),
        elements: rowsJson.map((i) => new Element.fromJson(i)).toList(),
        status: json['status']);
  }
}

class Element {
  final Distance distance;
  final Durations duration;
  final String status;

  Element({this.distance, this.duration, this.status});

  factory Element.fromJson(Map<String, dynamic> json) {
    return Element(
        distance: new Distance.fromJson(json['distance']),
        duration: new Durations.fromJson(json['duration']),
        status: json['status']);
  }
}

class Distance {
  final String text;
  final int value;

  Distance({this.text, this.value});

  factory Distance.fromJson(Map<String, dynamic> json) {
    return new Distance(text: json['text'], value: json['value']);
  }
}

class Durations {
  final String text;
  final int value;

  Durations({this.text, this.value});

  factory Durations.fromJson(Map<String, dynamic> json) {
    return new Durations(text: json['text'], value: json['value']);
  }
}