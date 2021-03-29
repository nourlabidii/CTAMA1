import 'dart:collection';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/screens/Saved_Parcelle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GooMap extends StatefulWidget {
  final LocationData location;
  GooMap({this.location});

  @override
  _GooMapState createState() => _GooMapState();
}

class _GooMapState extends State<GooMap> {
  LocationData _locationData;

  final DatabaseService databaseService = DatabaseService();

  Set<Polygon> _myPolySet;
  Polygon myPolygon;

  GoogleMapController _googleMapController;
  BitmapDescriptor _markerIcon;
  List<LatLng> polygonLatLngs = List<LatLng>();

  int _polygonIdCounter = 1;

  bool _isPolygon = true;

  // Draw Polygon to the map
  void _setPolygon() {
    myPolygon = Polygon(
      polygonId: PolygonId("1"),
      points: polygonLatLngs,
      strokeWidth: 2,
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    );
    if (myPolygon != null) {
      _myPolySet = HashSet<Polygon>()..add(myPolygon);
    } else {
      _myPolySet = HashSet<Polygon>();
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  Widget _fabPolygon() {
    return FloatingActionButton.extended(
      onPressed: () {
        //Remove the last point setted at the polygon
        setState(() {
          polygonLatLngs.removeLast();
        });
      },
      icon: Icon(Icons.undo),
      label: Text('Undo point'),
      backgroundColor: Colors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Identification parcelle'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        floatingActionButton:
            polygonLatLngs.length > 0 && _isPolygon ? _fabPolygon() : null,
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_locationData.latitude, _locationData.longitude),
                zoom: 16,
              ),
              mapType: MapType.hybrid,
              polygons: _myPolySet ?? HashSet<Polygon>(),
              myLocationEnabled: true,
              onTap: (point) {
                if (_isPolygon) {
                  setState(() {
                    polygonLatLngs.add(point);
                    _setPolygon();
                  });
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  RaisedButton(
                      color: Colors.black54,
                      onPressed: () {
                        _isPolygon = true;
                      },
                      child: Text(
                        'Polygon',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
