import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task/view/home_page.dart/home_page.dart';
import 'package:task/widgets/toggle_authentication.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    User? user=FirebaseAuth.instance.currentUser;
   return Scaffold(body: user!=null?HomePage():ToggleAuth(),);
  }
}