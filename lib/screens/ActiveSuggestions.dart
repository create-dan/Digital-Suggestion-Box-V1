// ActiveSuggestions widget
// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/screens/SingleSuggestion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActiveSuggestions extends StatefulWidget {
  @override
  State<ActiveSuggestions> createState() => _ActiveSuggestionsState();
}

class _ActiveSuggestionsState extends State<ActiveSuggestions> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Active Suggestions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('suggestions')
            .where('ownerUid', isEqualTo: uid)
            .where('status', isEqualTo: 'pending')
            .where('is_anonymous', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
            return Text('No active suggestions found');
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Map<String, dynamic> data = document.data()!;
              Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;

              return SingleSuggestion(
                suggestion: data['suggestion'],
                uid: data['uid'],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
