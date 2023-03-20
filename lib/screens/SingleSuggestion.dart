// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/screens/SuggestionDetailScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleSuggestion extends StatefulWidget {
  final SuggestionModel suggestion;
  final String uid;

  SingleSuggestion({super.key, required this.suggestion, required this.uid});

  @override
  State<SingleSuggestion> createState() => _SingleSuggestionState();
}

class _SingleSuggestionState extends State<SingleSuggestion> {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  String userName = '';

  @override
  Widget build(BuildContext context) {
    if (widget.suggestion == null) {
      return Container(); // or a loading indicator or an error message
    }

    DateTime dateTime = widget.suggestion.createdAt.toDate();
    String formattedDate = DateFormat('MMM d, y').format(dateTime);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestionDetailScreen(uid: widget.uid),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Color(0xffF7C8E0), width: 3),
          ),
          color: Color(0xffF9F9F9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   // colors: [
                  //   //   Color(0xffF472B6),
                  //   //   Color(0xffA89BFE),
                  //   // ],
                  // ),
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.dashboard_customize,
                      size: 30,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      (widget.suggestion.title.toString().split(" ").length >= 3
                          ? "${widget.suggestion.title.toString().split(" ").sublist(0, 3).join(" ")}..."
                          : widget.suggestion.title),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.suggestion.isAnonymous
                              ? "anonymous"
                              : widget.suggestion.username,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(width: 16),
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 8),
                        Text(
                          formattedDate,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.games_sharp,
                          color: Colors.deepOrange,
                        ),
                        SizedBox(width: 8),
                        Text(
                          widget.suggestion.status,
                          style: TextStyle(
                            fontSize: 18,
                            color: widget.suggestion.status == 'approved'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      children: (widget.suggestion.tags)
                          .map((tag) => Chip(
                                label: Text(tag),
                                backgroundColor: Color(0xffF2D2E4),
                              ))
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    // Row(
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(
                    //         Icons.thumb_up,
                    //         color: Colors.grey,
                    //       ),
                    //       onPressed: () {},
                    //     ),
                    //     SizedBox(width: 4),
                    //     Text(
                    //       widget.suggestion.upvotes.toString(),
                    //       style: TextStyle(fontSize: 16, color: Colors.black),
                    //     ),
                    //     SizedBox(width: 32),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
