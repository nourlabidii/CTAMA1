import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference markersCollection =
      FirebaseFirestore.instance.collection('Markers');
  final CollectionReference parcelleCollection =
      FirebaseFirestore.instance.collection('Parcelle');

  Future<void> userSetup(String displayName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();

    profileList.add({'name': displayName, 'uid': uid});
    return;
  }

  Future<void> createUserData(String name, String email, String uid) async {
    return await profileList.doc(uid).set({
      'name': name,
      'email': email,
    });
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addUsersToDb(Myuser myuser) async {
    try {
      await profileList.doc().set(myuser.toMap(myuser));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
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

  Future<bool> addParcelleToDB(MyPpolygon myPpolygon) async {
    try {
      await parcelleCollection.doc().set(myPpolygon.toMap(myPpolygon));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getSavedParcelles() {
    return parcelleCollection.snapshots();
  }
}
