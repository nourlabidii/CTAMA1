import 'dart:async';
import 'package:CTAMA/backend/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges();
  }

// THIS FUNCTION RETURN A BOOLEAN VALUE TRUE IF signIn get SUCCESS OTHERWISE RETURN FALSE
  Future signIn({String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

// THIS FUNCTION RETURN A BOOLEAN VALUE TRUE IF signup SUCCESS OTHERWISE RETURN FALSE
  Future signUp({String name, String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      await DatabaseService().createUserData(name, email, user.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  User getCurrentUser() => _firebaseAuth.currentUser;
}
