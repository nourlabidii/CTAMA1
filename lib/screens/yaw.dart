import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



 List<Placemark> placemark;
  String _address;
  void getAdress(double latitiude , double longitude)async{

placemark=
await Geolocator)().placemarkFromCoordinates(latitiude,longitude);
_address=placemark[0].nametoString()+","+placemark[0].locality.toString()+",Postal Code:"+placemark[0].postalcode.toString();
setState(() {
  _child=mapWidget();
});


  }
  void getCurrentLocation()async{
Position res= await Geolocator().getCurrentPosition();
setState(() {
  position=res;
_lat =position.latitude;
_lng=position.longitude;
});
await getAdress(_lat, _lng);

  }
  Set<Marker> _createMarker(){
return <Marker>[

Marker(

  markerId: MarkerId("home"),
  position: LatLng(position.latitude,position.longitude),
  icon:BitmapDescriptor.defaultMarker,
  infoWindow: InfoWindow(title:"Home",snippet: _address),
)



].toSet();


  }
  populateClients(){


FirebaseFirestore.instance.collection('Agences').get().then((doc){
  if(doc.docs.isNotEmpty){
for(int i=0; i< doc.docs.length; ++i){

initMarker(doc.docs[i].data(),doc.docs[i].id);
  }

  }

});

  }
  Map<MarkerId, Marker> markers=<MarkerId , Marker>{};

void initMarker(request, requestId){
var markerIdVal= requestId;
final MarkerId markerId=MarkerId(markerIdVal);
final Marker marker=Marker(
  markerId: markerId,
  position: LatLng(request['location'].latitude, request['location'].longitude ),
  infoWindow: InfoWindow(title:"fetched markers", snippet: request['address'] ),);
  setState(() {
      markers[markerId]=marker;
      print(markerId);

    });



}
Widget mapWidget(){


return GoogleMap(
  mapType: MapType.normal,
  markers: Set<Marker>.of(markers.values),
  initialCameraPosition: CameraPosition(
    target:LatLng(position.latitude,position.longitude),
    zoom: 16.0,
  
  
  ),
  onMapCreated: (GoogleMapController controller){


    _controller= controller;
  },
);
}