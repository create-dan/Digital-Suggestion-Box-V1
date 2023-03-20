// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/Auth/auth_helper.dart';

import 'package:dss/CustomCard.dart';
import 'package:dss/screens/canteen_gallary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../models/suggestion_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int totalUsers = 0;

  Future<void> getTotalUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();
    setState(() {
      totalUsers = snapshot.size;
    });
    // print(snapshot.size);
    // return snapshot.size;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getTotalUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xffF7C8E0),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('suggestions')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              List<SuggestionModel> suggestions = snapshot.data!.docs
                  .map((doc) => SuggestionModel.fromJson(doc.data()))
                  .toList();

              int activeSuggestion = 0;
              int approvedSuggestion = 0;

              for (SuggestionModel suggestionModel in suggestions) {
                if (suggestionModel.status == "pending") activeSuggestion++;
                if (suggestionModel.status == "approved") approvedSuggestion++;
              }

              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // SizedBox(
                  //   height: 150,
                  //   child: Lottie.network(
                  //       'https://assets3.lottiefiles.com/packages/lf20_4kxDIRVtSo.json'),
                  // ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        icon: Icons.lightbulb_outline,
                        iconColor: Color(0xFF3383CD),
                        title: 'Total Suggestions',
                        value: suggestions.length.toString(),
                      ),
                      CustomCard(
                        icon: Icons.access_time,
                        iconColor: Color(0xFF3383CD),
                        title: 'Active',
                        value: activeSuggestion.toString(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCard(
                        icon: Icons.check_circle_outline,
                        iconColor: Color(0xFF3383CD),
                        title: 'Approved ',
                        value: approvedSuggestion.toString(),
                      ),
                      CustomCard(
                        icon: Icons.people_outline,
                        iconColor: Color(0xFF3383CD),
                        title: 'Total Users',
                        value: totalUsers.toString(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      child: ListTile(
                          leading: Icon(Icons.browse_gallery,
                              size: 30, color: Colors.blue),
                          title: Text(
                            'Canteen Gallary',
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
                  ),
                  Center(
                    child: ListTile(
                      leading: Icon(Icons.logout, size: 30, color: Colors.blue),
                      title: Text(
                        'Log Out',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                  SizedBox(height: 100),
                ],
              );
            }),
      ),
    );
  }
}
