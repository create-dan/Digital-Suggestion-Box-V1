// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class HowToUseApp extends StatelessWidget {
  const HowToUseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Use'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              'Rules for using the app',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                  'If you want to keep track of your suggestions Post non-anonymously'),
            ),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.red),
              title: Text('Do not post any inappropriate content'),
            ),
            SizedBox(height: 16),
            Text(
              'Additional guidelines',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('Be respectful and considerate of others'),
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text('Do not spam or advertise in the app'),
            ),
          ],
        ),
      ),
    );
  }
}
