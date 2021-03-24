import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/myPolygons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference ctamaCollection =
      FirebaseFirestore.instance.collection('Ctama');
  final CollectionReference markersCollection =
      FirebaseFirestore.instance.collection('Markers');
  final CollectionReference polygonsCollection =
      FirebaseFirestore.instance.collection('Polygons');
  final String uid;

  DatabaseService({this.uid});

  Future updateUserData(String name, int role, String email) async {
    return await ctamaCollection.doc(uid).set({
      'name': name,
      'role': role,
      'email': email,
    });
  }

  Future<bool> addMarkersToDb(Mymarker mymarker) async {
    try {
      await markersCollection.doc().set(mymarker.toMap(mymarker));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getMarkersStream() {
    return markersCollection.snapshots();
  }

  Future<bool> addPolygonsToDb(MyPolygon mypolygon) async {
    try {
      await markersCollection.doc().set(mypolygon.toMap(mypolygon));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getPolygonsStream() {
    return polygonsCollection.snapshots();
  }
}
