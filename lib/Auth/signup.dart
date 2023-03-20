// ignore_for_file: prefer_const_constructors

import 'package:dss/Auth/auth_helper.dart';
import 'package:dss/Auth/login_screen.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/screens/HomeScreen.dart';
import 'package:dss/services/get_user_data.dart';
import 'package:dss/services/user_services.dart';
import 'package:dss/widgets/MyTextFormField.dart';
import 'package:dss/widgets/my_bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:lottie/lottie.dart';

import '../helper/validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formFieldKey = GlobalKey();

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  String? _validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formFieldKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Lottie.network(
                    "https://assets1.lottiefiles.com/packages/lf20_mygDmv6L3F.json"),
                SizedBox(
                  height: 10.0,
                ),

                // MyTextFormField(
                //     name: "Bio",
                //     onChange: (val) {
                //       setState(() {
                //         _bio = val;
                //       });
                //     }),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: "User Name",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: nameValidator,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "email",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: emailValidator,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: passwordValidator,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: confirmpasswordController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: _validateConfirmPassword,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: "Mobile No",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formFieldKey.currentState!.validate()) {
                        AuthHelper()
                            .signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        )
                            .then(
                          (val) async {
                            print(emailController.text);
                            print(passwordController.text);

                            if (val == null) {
                              String uid = FirebaseAuth
                                  .instance.currentUser!.uid
                                  .toString();
                              await UserService()
                                  .addUser(
                                    UserModel(
                                      username: usernameController.text,
                                      prn: '2020BTEIT00032',
                                      email: emailController.text,
                                      password: passwordController.text,
                                      mobile: mobileController.text,
                                      image: 'just',
                                      uid: uid,
                                    ),
                                  )
                                  .then(
                                    (value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GetUserData(),
                                      ),
                                    ),
                                  );
                            }
                          },
                        );
                      }
                    },
                    child: Text("Sign Up"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  child: Container(
                    child: Text("Already have an account ? Log In "),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
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
