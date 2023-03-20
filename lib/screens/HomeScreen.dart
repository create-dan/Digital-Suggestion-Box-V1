// // ignore_for_file: prefer_const_constructors
//
// import 'package:dss/data/data.dart';
// import 'package:dss/screens/SingleSuggestion.dart';
// import 'package:flutter/material.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Suggestions'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: ListView.builder(
//           itemCount: demoSuggestions.length,
//           itemBuilder: (BuildContext context, int index) {
//             return SingleSuggestion(suggestion: demoSuggestions[index]);
//           },
//         ),
//       ),
//     );
//   }
// }
