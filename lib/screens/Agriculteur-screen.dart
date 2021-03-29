import 'dart:async';
import 'package:CTAMA/backend/database.dart';
import 'package:flutter/material.dart';
import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
              onPressed: () => authenticationService.signOut(),
              icon: Icon(Icons.logout))
        ],
      ),
      body: Center(child: Text("Home")),
    );
  }
}
