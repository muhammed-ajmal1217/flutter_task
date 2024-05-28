import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controller/login_provider.dart';
import 'package:task/view/login_page/login_page.dart';
import 'package:task/view/signup_page/signup_page.dart';

class ToggleAuth extends StatefulWidget {
  const ToggleAuth({super.key});

  @override
  State<ToggleAuth> createState() => _ToggleAuthState();
}

class _ToggleAuthState extends State<ToggleAuth> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    if (loginProvider.showLogin) {
      return LoginPage(
        showSignUp: loginProvider.toggleScreen,
      );
    } else {
      return SignupPage(
        showLogin: loginProvider.toggleScreen,
      );
    }
  }
}