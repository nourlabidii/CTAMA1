import 'package:cloud_firestore/cloud_firestore.dart';

class MyPolygon {
  List<dynamic> geoPoint;

  MyPolygon({this.geoPoint});

  Map<String, dynamic> toMap(MyPolygon mypolygon) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["pos"] = mypolygon.geoPoint;

    return map;
  }

  MyPolygon.fromMap(Map<String, dynamic> map) {
    this.geoPoint = map["pos"];
  }
}
