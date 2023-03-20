// ignore_for_file: prefer_const_constructors

import 'package:dss/Auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  // SignUp Method
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Register successfully');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignIn method
  Future signIn({required String email, required String password}) async {
    print(email);
    print(password);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Login successfully');

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SignOut Method
  Future signOut(context) async {
    await _auth.signOut();
    print('signout');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
        (route) => false);
  }

  Future verifyEmail({required context}) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Verification email has been sent',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}
