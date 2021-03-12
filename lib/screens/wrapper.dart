import 'package:CTAMA/backend/user.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CTAMA/screens/create-new-account.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return LoginScreen();
    } else {
      return CreateNewAccount();
    }
  }
}
