// ignore_for_file: prefer_const_constructors

import 'package:dss/Admin/Dashboard.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/screens/HomeScreen.dart';
import 'package:dss/screens/SuggestionDetailScreen.dart';
import 'package:dss/screens/add_suggestion_desc.dart';
import 'package:dss/screens/profile_page.dart';
import 'package:dss/screens/render_all_suggestions.dart';

import 'package:flutter/material.dart';

class MyBottom extends StatefulWidget {
  const MyBottom({Key? key, this.idx = 2}) : super(key: key);

  final int idx;
  @override
  _MyBottomState createState() => _MyBottomState();
}

class _MyBottomState extends State<MyBottom> {
  final List<String> items = [
    'Hygiene',
    'Food',
    'Unavailability',
    'Taste',
  ];
  String? selectedValue;
  int _index = 1;
  List<Widget> screens = [
    CurrUser.isAdmin! ? RenderAllSuggestions() : AddSuggestionDesc(),
    CurrUser.isAdmin! ? Dashboard() : ProfilePage(),
    // HomeScreen(),
  ];

  void onItemTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Color unSelectedIconColor =  Color(0xff333146);
    // Color selectedIconColor =Colors.white ;
    // Color backgroundColor = Colors.white;
    Color color = Color(0xff05BFDB);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: ClipRect(

        child: BottomNavigationBar(
          backgroundColor: color,
          items: [
            BottomNavigationBarItem(
              icon: CurrUser.isAdmin!
                  ? Icon(
                Icons.dashboard,
                size: 32,
                // color:
              )
                  : Icon(
                Icons.add_circle_outline_outlined,
                // color:
                size: 32,
              ),
              label: CurrUser.isAdmin! ?"All Suggestion" : "Add Suggestion",
            ),
            BottomNavigationBarItem(

              icon: Icon(
                Icons.home,
                size: 32,
              ),
              label: "Home",
            ),
          ],
          onTap: onItemTap,
          currentIndex: _index,
          selectedItemColor: Colors.pink[600],
        ),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: screens[_index],
      ),
    );
  }
}
