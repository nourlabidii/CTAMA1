import 'package:flutter/material.dart';
import 'package:CTAMA/backend/authentication_services.dart';

class Homepage extends StatelessWidget {
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('CTAMA'),
        backgroundColor: Colors.orange[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              authenticationService.signOut();
            },
          )
        ],
      ),
    );
  }
}
