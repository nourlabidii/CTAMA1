import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference ctamaCollection =
      FirebaseFirestore.instance.collection('Ctama');

  final String uid;

  DatabaseService({this.uid});

  Future updateUserData(String name, int role, String email) async {
    return await ctamaCollection.doc(uid).set({
      'name': name,
      'role': role,
      'email': email,
    });
  }
}
