// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/screens/MySuggestion/MySuggestionCard.dart';
import 'package:dss/widgets/my_bottom.dart';
import 'package:flutter/material.dart';

class MySuggestions extends StatefulWidget {
  final String ownerUid;

  MySuggestions({Key? key, required this.ownerUid}) : super(key: key);

  @override
  State<MySuggestions> createState() => _MySuggestionsState();
}

class _MySuggestionsState extends State<MySuggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Suggestions'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('suggestions')
            .where('ownerUid', isEqualTo: widget.ownerUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data == null || snapshot.data!.size == 0) {
            return Text('No suggestions found for this user.');
          }

          return ListView.builder(
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              SuggestionModel suggestion =
                  SuggestionModel.fromFirestore(snapshot.data!.docs[index]);
              if (suggestion == null) {
                return SizedBox.shrink();
              }
              return MySuggestionCard(suggestion: suggestion);
            },
          );
        },
      ),
    );
  }
}
