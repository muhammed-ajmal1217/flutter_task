import 'package:flutter/material.dart';
import 'package:task/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  signUp({String? email, String? password, String? userName}) async {
    try {
      await AuthService().signupWithEmail(
          email: email!, password: password!, userName: userName!);
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }

  signIn({String? email, String? password, BuildContext? context}) async {
    try {
      await AuthService().signinWithEmail(
          email: email!, password: password!, context: context!);
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }

  signOut() async {
    try {
      await AuthService().signOut();
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }
}
