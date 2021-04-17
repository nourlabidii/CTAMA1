import 'package:CTAMA/backend/database.dart';
import 'package:CTAMA/models/myMarker.dart';
import 'package:CTAMA/models/parcelle_poly.dart';
import 'package:CTAMA/screens/SavedPar_View.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:CTAMA/screens/Agent/saved_agences_view.dart';

class SavedParcelle extends StatelessWidget {
  SavedParcelle({Key key}) : super(key: key);

  final DatabaseService databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SAVED PARCELLES"),
      ),
      body: StreamBuilder(
        stream: databaseService.getSavedParcelles(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.docs.isEmpty) {
              return Center(
                child: Text("Aucune parcelles ajoutés.",
                    style: TextStyle(fontSize: 23)),
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
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          leading: Text("Parcelle n° $index ",
                              style: TextStyle(fontSize: 29)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete_forever_rounded),
                            color: Colors.red,
                            onPressed: () {},
                          ),
                        ),
                      ),
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
