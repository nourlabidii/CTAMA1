class MyPpolygon {
  List<dynamic> myPolygonP;

  MyPpolygon({this.myPolygonP});

  Map<String, dynamic> toMap(MyPpolygon mymarker) {
    Map<String, dynamic> map = Map<String, dynamic>();

    map["positions"] = mymarker.myPolygonP;

    return map;
  }

  MyPpolygon.fromMap(Map<String, dynamic> map) {
    this.myPolygonP = map["positions"];
  }
}
