import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/model/user_model.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  signinWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
          log("message");
      return user;
    } on FirebaseAuthException catch (error) {
      String errorCode = 'error with Sign-in';
      if (error.code == 'wrong-password' || error.code == 'user-not-found') {
        errorCode = "Incorrect email or password";
      } else if (error.code == 'user-disabled') {
        errorCode = "User not found";
      } else {
        errorCode = error.code;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            errorCode,
            style: TextStyle(color: Colors.black),
          )));
      return null;
    }
  }

  signupWithEmail(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userData =
          UserModel(email: email, name: userName, uid: user.user?.uid);
      firestore.collection('users').doc(user.user?.uid).set(userData.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Signup is interrupted because$e');
    }
  }
    Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
