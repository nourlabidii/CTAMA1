import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Agences extends StatefulWidget {
  final LocationData location;
  Agences({this.location});
  @override
  _AgencesState createState() => _AgencesState();
}

class _AgencesState extends State<Agences> {
  // Location
  LocationData _locationData;

  // Maps
  Set<Marker> _markers = HashSet<Marker>();

  GoogleMapController _googleMapController;
  BitmapDescriptor _markerIcon;

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
          markerId: MarkerId(markerIdVal),
          position: point,
        ),
      );
    });
  }

  // Start the map with this marker setted up
  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;

    setState(() {
      _markers.add(
        Marker(
          draggable: true,
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          },

          markerId: MarkerId('0'),
          position: LatLng(-20.131886, -47.484488),
          infoWindow: InfoWindow(title: 'marker', snippet: 'c' 'est un mark'),
          //icon: _markerIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Identification parcelle'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(_locationData.latitude, _locationData.longitude),
                  zoom: 16,
                ),
                mapType: MapType.hybrid,
                markers: _markers,
                myLocationEnabled: true,
                onTap: (point) {
                  if (_isMarker) {
                    setState(() {
                      _markers.clear();
                      _setMarkers(point);
                    });
                  }
                }),
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
