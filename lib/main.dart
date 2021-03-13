import 'package:CTAMA/backend/authentication_services.dart';
import 'package:CTAMA/screens/Agriculteur-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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
    // here is the important part we
    //will listen for user changes if user become null the screen navigate to LOgin screen else
    // navigate to HOME PAGE and stay there until user change value to null
    authenticationService.authStateChanges.listen((user) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (cntx) => user != null ? Homepage() : LoginScreen()),
            (dynamic route) => false);
      });
    });

    return Center(child: CircularProgressIndicator());
  }
}
