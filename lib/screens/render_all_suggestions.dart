// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/screens/NoSuggestion.dart';

import 'package:dss/screens/SingleSuggestion.dart';
import 'package:flutter/material.dart';

class RenderAllSuggestions extends StatefulWidget {
  const RenderAllSuggestions({Key? key}) : super(key: key);

  @override
  State<RenderAllSuggestions> createState() => _RenderAllSuggestionsState();
}

class _RenderAllSuggestionsState extends State<RenderAllSuggestions> {
  // Stream<List<SuggestionModel>> getAllSuggestions() {
  //   print(CurrUser.uid);
  //   return FirebaseFirestore.instance
  //       .collection('suggestions')
  //       .where('ownerUid', isEqualTo: CurrUser.uid)
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map(
  //         (querySnapshot) => querySnapshot.docs.map(
  //           (documentSnapshot) {
  //             // print(documentSnapshot.data()['ownerUid']);
  //             return SuggestionModel.fromJson(documentSnapshot.data());
  //           },
  //         ).toList(),
  //       );
  // }

  Stream<List<SuggestionModel>> getAllSuggestions() {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('suggestions');
    Query query;

    // Check if the user is an admin
    if (CurrUser.isAdmin!) {
      // Get all suggestions if the user is an admin
      query = collection.orderBy('createdAt', descending: true);
    } else {
      // Get suggestions for the current user
      query = collection
          .where('ownerUid', isEqualTo: CurrUser.uid)
          .orderBy('createdAt', descending: true);
    }

    return query.snapshots().map(
          (querySnapshot) => querySnapshot.docs.map(
            (documentSnapshot) {
              // print(documentSnapshot.data()['ownerUid']);
              Map<String, dynamic> data =
                  documentSnapshot.data() as Map<String, dynamic>;
              return SuggestionModel.fromJson(data);
            },
          ).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: kBackGroundColor,
      backgroundColor: Color(0xffEFF5F5),
      appBar: AppBar(
        // backgroundColor: Color(0xff3A98B9),
        backgroundColor: Color(0xffF7C8E0),
        title: Text(
          'All Suggestions',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<List<SuggestionModel>>(
                stream: getAllSuggestions(),
                builder: (context, snapshot) {
                  print(snapshot.hasData);
                  if (snapshot.hasData) {
                    List<SuggestionModel>? suggestions = snapshot.data;

                    if (suggestions!.isEmpty) {
                      return NoSuggestionsScreen();
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: suggestions.length,
                          itemBuilder: (context, index) {
                            SuggestionModel suggestion = suggestions[index];
                            // Display suggestion
                            // return Container(
                            //   child: Column(
                            //     children: [
                            //       Text(suggestion.description),
                            //       Text(suggestion.ownerUid),
                            //       Text(suggestion.isAnonymous.toString()),
                            //       Text(suggestion.createdAt.toString()),
                            //     ],
                            //   ),
                            // );
                            return SingleSuggestion(
                                suggestion: suggestion, uid: suggestion.uid);
                          },
                        ),
                      );
                    }
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
