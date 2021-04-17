import 'package:cloud_firestore/cloud_firestore.dart';

class Myuser {
  String name;
  String email;
  int role;

  Myuser({this.name, this.email});

  Map<String, dynamic> toMap(Myuser myuser) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["name"] = myuser.name;
    map["email"] = myuser.email;
    return map;
  }

  Myuser.fromMap(Map<String, dynamic> map) {
    this.name = map["name"];
    this.email = map["email"];
  }
}
