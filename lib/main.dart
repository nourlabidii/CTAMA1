import 'package:CTAMA/screens/Admin-Panel.dart';
import 'package:CTAMA/screens/ajouter-agence.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:CTAMA/screens/parcelle.dart';
import 'package:CTAMA/screens/login-screen.dart';
import 'backend/authentication_services.dart';
import 'screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTAMA',
      theme: ThemeData(
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  AuthenticationWrapper({Key key}) : super(key: key);

  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return authenticationService.getCurrentUser() != null
        ? Dashboard()
        : Ajoutagence();
  }
}

/*  authenticationService.authStateChanges.listen((user) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.push(
        context, 
        MaterialPageRoute(builder: (cntx)=>user!=null?Homepage():LoginScreen()),
    );
      });
    });
    
    return Center(child: CircularProgressIndicator()); */
