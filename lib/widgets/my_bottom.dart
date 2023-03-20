// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  int _index = 1;
  List<Widget> screens = [
    CurrUser.isAdmin! ? RenderAllSuggestions() : AddSuggestionDesc(),
    // CurrUser.isAdmin! ? Container() : AddSuggestionDesc(),

    CurrUser.isAdmin! ? Dashboard() : ProfilePage(),
    // HomeScreen(),

    // ProfilePage(),
  ];

  void onItemTap(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color unSelectedIconColor = Colors.white;
    Color selectedIconColor = Colors.white;
    Color backgroundColor = Colors.blue;
    Color color = Color(0xffff13005A);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: backgroundColor,
      bottomNavigationBar: CurvedNavigationBar(
        color: color,
        buttonBackgroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        key: _bottomNavigationKey,
        index: _index,
        height: 65,
        items: [
          CurrUser.isAdmin!
              ? Icon(
                  Icons.dashboard,
                  size: 32,
                  color: _index == 0 ? selectedIconColor : unSelectedIconColor,
                )
              : Icon(
                  Icons.add,
                  color: _index == 1 ? selectedIconColor : unSelectedIconColor,
                  size: 40,
                ),
          Icon(
            Icons.home,
            color: _index == 2 ? selectedIconColor : unSelectedIconColor,
            size: 32,
          ),
        ],
        onTap: (index) => setState(() {
          onItemTap(index);
        }),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: screens[_index],
      ),
    );
  }
}
