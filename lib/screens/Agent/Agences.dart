import 'dart:collection';
import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';

import 'package:flutter/cupertino.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Saved_Agence.dart';

class Agences extends StatefulWidget {
  final LocationData location;

  Agences({
    this.location,
  });
  @override
  _AgencesState createState() => _AgencesState();
}

class _AgencesState extends State<Agences> {
  // Location
  LocationData _locationData;

  // Maps
  Set<Marker> _markers = HashSet<Marker>();

  List<LatLng> markerLatLngs = <LatLng>[];

  GoogleMapController _googleMapController;

  String searchAddr;

  BitmapDescriptor _markerIcon;

  final DatabaseService databaseService = DatabaseService();
  //ids

  int _markerIdCounter = 1;

  // Type controllers

  bool _isMarker = false;

  @override
  void initState() {
    super.initState();
    // If I want to change the marker icon:
    // _setMarkerIcon();
    _locationData = widget.location;
  }

  // This function is to change the marker icon
  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/farm.png');
  }

  // Set Markers to the map
  void _setMarkers(LatLng point) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      print(
          'Marker | Latitude: ${point.latitude}  Longitude: ${point.longitude}');
      _markers.add(
        Marker(
          onTap: () {
            print(" MARKER N°$markerIdVal TAPED");
            setState(() {
              _markers.removeWhere(
                  (element) => element.markerId.value == markerIdVal);
            });
          },
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  Widget _undomarker() {
    return FloatingActionButton.extended(
      onPressed: () {
        //Remove marker
        setState(() {
          _markers.remove(_markers.last);
        });
      },
      icon: Icon(Icons.undo),
      label: Text('Undo point'),
      backgroundColor: Colors.orange,
    );
  }

  @override
  Widget build(BuildContext context) {
    void showSnackbar(bool isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Container(
            child: Text(
              isSuccess ? "Success" : "fail",
              style: TextStyle(fontSize: 18),
            ),
            padding: EdgeInsets.all(15),
          ),
          backgroundColor: isSuccess ? Colors.green : Colors.red));
    }

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (cntx) => SavedAgences())),
                icon: Icon(Icons.save)),
            IconButton(
                onPressed: () async {
                  databaseService
                      .addMarkersToDb(Mymarker(
                          geoPoint: _markers
                              .toList()
                              .map((e) => GeoPoint(
                                  e.position.latitude, e.position.longitude))
                              .toList()))
                      .then((value) => showSnackbar(value));
                },
                icon: Icon(Icons.add))
          ],
          title: Text('localisation agences'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        floatingActionButton: _undomarker(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(_locationData.latitude, _locationData.longitude),
                  zoom: 16,
                ),
                markers: _markers,
                myLocationEnabled: false,
                onTap: (point) {
                  if (_isMarker) {
                    setState(() {
                      _setMarkers(point);
                    });
                  }
                }),
            Positioned(
                top: 30.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white),
                  child: TextField(
                    onTap: () {},
                    decoration: InputDecoration(
                        hintText: 'Entrer adresse',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () async {},
                          iconSize: 30.0,
                        )),
                    onChanged: (val) {
                      setState(() {
                        searchAddr = val;
                      });
                    },
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  RaisedButton(
                      color: Colors.black54,
                      onPressed: () {
                        _isMarker = true;
                      },
                      child: Text('Marker',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
                ],
              ),
            )
          ],
        ));
  }
}
