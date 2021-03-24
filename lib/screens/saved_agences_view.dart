import 'package:CTAMA/models/myMarker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SavedAgentView extends StatelessWidget {
  const SavedAgentView({Key key, this.mymarker}) : super(key: key);

  final Mymarker mymarker;

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _markers = mymarker.geoPoint
        .map((e) => Marker(
              markerId: MarkerId("${e.hashCode}"),
              position: LatLng(e.latitude, e.longitude),
            ))
        .toSet();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: kToolbarHeight),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(_markers.first.position.latitude,
                _markers.first.position.longitude),
            zoom: 16,
          ),
          markers: _markers,
          myLocationEnabled: false,
        ),
      ),
    );
  }
}
