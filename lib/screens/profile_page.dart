// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dss/Auth/auth_helper.dart';
import 'package:dss/Auth/signup.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/screens/ActiveSuggestions.dart';
import 'package:dss/screens/MySuggestion/MySuggestions.dart';
import 'package:dss/screens/SingleSuggestion.dart';
import 'package:dss/screens/canteen_gallary.dart';
import 'package:dss/screens/how_to_user_app.dart';
import 'package:dss/screens/render_all_suggestions.dart';
import 'package:dss/widgets/SnackBar.dart';
import 'package:flutter/material.dart';

import '../models/suggestion_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Color(0xff05BFDB),
          leading: Icon(Icons.manage_accounts_outlined),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000'),
                  ),
                  SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        CurrUser.username.toString().toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      // Text(
                      //   'PRN:- ${CurrUser.prn.toString()}',
                      //   style: TextStyle(
                      //     fontSize: 16.0,
                      //     color: Colors.purple,
                      //   ),
                      // ),
                      SizedBox(height: 10.0),
                      Text(
                        CurrUser.email.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        child: Text(
                          CurrUser.mobile.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.0),

              SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                color: Colors.white,
                // child: ListTile(
                //   leading: Icon(Icons.lightbulb, size: 30, color: Colors.blue),
                //   title: Text(
                //     'My Suggestions',
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               // MySuggestions(ownerUid: CurrUser.uid.toString()),
                //
                //     );
                //   },
                // ),
              ),
              SizedBox(
                height: 8,
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(10),
              //     side: BorderSide(color: Colors.grey.shade300),
              //   ),
              //   color: Colors.white,
              //   child: ListTile(
              //     leading: Icon(Icons.person, size: 30, color: Colors.blue),
              //     title: Text(
              //       'Active Suggestions',
              //       style: TextStyle(fontWeight: FontWeight.bold),
              //     ),
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => ActiveSuggestions(),
              //         ),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 8,
              ),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.data_saver_on_sharp,
                      size: 30, color: Colors.blue),
                  title: Text(
                    'Track My Suggestions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RenderAllSuggestions(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.info, size: 30, color: Colors.blue),
                  title: Text(
                    'GuideLines and Rules',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HowToUseApp(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: ListTile(
                    leading: Icon(Icons.browse_gallery,
                        size: 30, color: Colors.blue),
                    title: Text(
                      'Canteen Gallery',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CanteenGallery(),
                        ),
                      );
                    }),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                color: Colors.white,
                child: ListTile(
                  leading: Icon(Icons.logout, size: 30, color: Colors.blue),
                  title: Text(
                    'Log Out',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("LogOut"),
                            content: Text("Are You Sure to logout?"),
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )),
                              IconButton(
                                  onPressed: () async {
                                    await AuthHelper().signOut(context);
                                  },
                                  icon: Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )),
                            ],
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
