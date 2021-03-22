import 'dart:async';

import 'package:flutter/material.dart';
import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/screens/screens.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final AuthenticationService authenticationService = AuthenticationService();
  StreamSubscription userSub;

  void pushNavToLoginScreen({@required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (cntx) => LoginScreen()),
        (dynamic route) => false);
  }

  @override
  void initState() {
    super.initState();
    userSub = authenticationService.authStateChanges
        .listen((event) => event ?? pushNavToLoginScreen(context: context));
  }

  @override
  void dispose() {
    userSub.cancel();
    super.dispose();
  }

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
