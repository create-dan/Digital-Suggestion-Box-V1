// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:dss/Admin/Dashboard.dart';
import 'package:dss/Auth/login_screen.dart';
import 'package:dss/Just1.dart';
import 'package:dss/admin_user.dart';
import 'package:dss/screens/Forget_password.dart';
import 'package:dss/screens/HomeScreen.dart';
import 'package:dss/screens/Just.dart';

import 'package:dss/services/get_user_data.dart';
import 'package:dss/sumit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'screens/add_suggestion_desc.dart';
import 'widgets/my_bottom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user == null ? LoginScreen() : GetUserData(),
      // home: ForgotPasswordScreen(),
      // home: Sumit(),
    );
  }
}
