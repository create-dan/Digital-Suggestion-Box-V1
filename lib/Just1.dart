// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dss/CustomCard.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Just1 extends StatefulWidget {
  @override
  State<Just1> createState() => _Just1State();
}

class _Just1State extends State<Just1> {
  @override
  Widget build(BuildContext context) {
    // final totalSuggestions = 15;
    // final activeSuggestions = 10;
    // final approvedSuggestions = 5;
    // final totalUsers = 50;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3383CD),
                    Color(0xFF11249F),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Positioned(
                  //   bottom: -50,
                  //   left: -100,
                  //   child: Lottie.network(
                  //     'https://assets7.lottiefiles.com/packages/lf20_2FVja5lGX9.json',
                  //     height: MediaQuery.of(context).size.height * 0.4,
                  //   ),
                  // ),
                  // Image.network(
                  //   'https://img.freepik.com/free-vector/flat-design-illustration-customer-support_23-2148887720.jpg?w=740&t=st=1677523562~exp=1677524162~hmac=79b78c56f1d4ebf0b347261bd698349a569e012c489a16f9bc254dbdcc54760f',
                  // ),
                  Container(
                    width: double.infinity,
                    child: Image.network(
                      'https://img.freepik.com/free-vector/flat-design-illustration-customer-support_23-2148887720.jpg?w=740&t=st=1677523562~exp=1677524162~hmac=79b78c56f1d4ebf0b347261bd698349a569e012c489a16f9bc254dbdcc54760f',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  // Positioned(
                  //   top: 150,
                  //   left: 100,
                  //   child: Text(
                  //     'Admin Dashboard',
                  //     style: TextStyle(
                  //       color: Colors.red,
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 28,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                  icon: Icons.lightbulb_outline,
                  iconColor: Color(0xFF3383CD),
                  title: 'Total Suggestions',
                  value: "totalSuggestions",
                ),
                CustomCard(
                  icon: Icons.access_time,
                  iconColor: Color(0xFF3383CD),
                  title: 'Active Suggestions',
                  value: "activeSuggestions",
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                  icon: Icons.check_circle_outline,
                  iconColor: Color(0xFF3383CD),
                  title: 'Approved Suggestions',
                  value: "approvedSuggestions",
                ),
                CustomCard(
                  icon: Icons.people_outline,
                  iconColor: Color(0xFF3383CD),
                  title: 'Total Users',
                  value: "totalUsers",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
