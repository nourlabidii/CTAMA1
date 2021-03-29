import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'saved_agences_view.dart';

class SavedParcelle extends StatelessWidget {
  SavedParcelle({Key key}) : super(key: key);

  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SAVED AGENCES"),
      ),
      body: StreamBuilder(
        stream: databaseService.getSavedParcelles(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("NO DATA HERE."),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final MyPpolygon myPpolygon =
                    MyPpolygon.fromMap(snapshot.data.docs[index].data());
                return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (cntx) => SavedParcView(
                              myPpolygon: myPpolygon,
                            ))),
                    child: ListTile(
                      leading: Text("Parcelle n° $index "),
                    ));
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
