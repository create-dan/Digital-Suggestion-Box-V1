// ignore_for_file: prefer_const_constructors

import 'package:dss/Auth/auth_helper.dart';
import 'package:dss/Auth/signup.dart';
import 'package:dss/helper/validators.dart';
import 'package:dss/screens/Forget_password.dart';
import 'package:dss/screens/HomeScreen.dart';
import 'package:dss/services/get_user_data.dart';
import 'package:dss/widgets/my_bottom.dart';
import 'package:dss/widgets/navinSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email = "", _password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Lottie.network(
                    "https://assets8.lottiefiles.com/packages/lf20_puciaact.json"),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  "Digital Suggestion Box",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  // onChanged: (input) {
                  //   setState(() {
                  //     _email = input;
                  //   });
                  // },
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  validator: emailValidator,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                  ),
                  controller: passwordController,
                  obscureText: true,
                  // onChanged: (input) {
                  //   setState(() {
                  //     _password = input;
                  //   });
                  // },
                  validator: passwordValidator,
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: Text("Forgot Password?"),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        AuthHelper()
                            .signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        )
                            .then(
                          (val) {
                            print(emailController.text);
                            print(passwordController.text);

                            if (val == null) {
                              return Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetUserData(),
                                ),
                              );
                            } else {
                              showSnackbar(context, Colors.red, val.toString());
                            }
                          },
                        );
                      }
                    },
                    child: Text("LOGIN"),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  child: Container(
                    child: Text("Don't have an account ? Sign Up "),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
