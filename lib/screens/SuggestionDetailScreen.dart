// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/Admin/SuggestionActionScreen.dart';
import 'package:dss/data/data.dart';
import 'package:dss/main.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuggestionDetailScreen extends StatefulWidget {
  final String uid;

  SuggestionDetailScreen({required this.uid});

  @override
  State<SuggestionDetailScreen> createState() => _SuggestionDetailScreenState();
}

class _SuggestionDetailScreenState extends State<SuggestionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('suggestions')
          .doc(widget.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text('No data found.'),
          );
        }

        final suggestion = snapshot.data!;
        int totalUpvotes = suggestion['upvotes'];

        bool isLiked = false;

        //display date
        DateTime dateTime = suggestion['createdAt'].toDate();
        String formattedDate = DateFormat('MMM d, y').format(dateTime);

        final String approvedMessage = suggestion['approvedMessage'];
        final String status = suggestion['status'];

        void _incrementUpvoteCount() async {
          await FirebaseFirestore.instance
              .collection('suggestions')
              .doc(widget.uid)
              .update({'upvotes': suggestion['upvotes'] + 1});

          // setState(() {
          //
          // });
        }

        void _decrementUpvoteCount() async {
          await FirebaseFirestore.instance
              .collection('suggestions')
              .doc(widget.uid)
              .update({'upvotes': suggestion['upvotes'] - 1});

          // setState(() {
          //
          // });
        }

        Future<bool?> showConfirmationDialog(BuildContext context) async {
          return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmation'),
                content: Text(
                    'Are you sure you want to upvote this suggestion? If yes then you will not be able to change this in future .'),
                actions: <Widget>[
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: Text('Yes'),
                    onPressed: () async {
                      totalUpvotes++;

                      setState(() {});

                      await FirebaseFirestore.instance
                          .collection('suggestions')
                          .doc(widget.uid)
                          .update({'upvotes': suggestion['upvotes'] + 1});
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            },
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                // CircleAvatar(
                //   backgroundImage: NetworkImage(
                //       "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000"),
                // ),
                // SizedBox(width: 10.0),
                Text(
                  'Your Detailed Suggestion',
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image.network(suggestion['imageUrl']),
                suggestion['imageUrl'] != "imageUrl"
                    ? Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          height: 200, // Set the desired height of the image
                          width: double
                              .infinity, // Set the width to match the parent widget
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffECF2FF),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),

                          child: ClipRRect(
                            child: Stack(
                              children: [
                                Image.network(
                                  suggestion['imageUrl'],
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) {
                                      return child;
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            suggestion['title'],
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextStyling(
                                    text: formattedDate,
                                    color: Colors.black.withOpacity(0.8),
                                    size: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  TextStyling(
                                    text: "Description :",
                                    color: Colors.black.withOpacity(0.8),
                                    size: 20,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Apptext(
                                    text: suggestion['description'],
                                    color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     print("print");
                              //   },
                              //   child: Row(
                              //     // mainAxisAlignment:
                              //     //     MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       IconButton(
                              //         icon: isLiked
                              //             ? Icon(Icons.favorite)
                              //             : Icon(Icons.favorite_border),
                              //         onPressed: () {
                              //           setState(() {
                              //             isLiked = !isLiked;
                              //           });
                              //           if (isLiked) {
                              //             _incrementUpvoteCount();
                              //           } else {
                              //             _decrementUpvoteCount();
                              //           }
                              //         },
                              //       ),
                              //       Text(
                              //         suggestion['upvotes'].toString(),
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 25,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        spacing: 8,
                        children: (suggestion['tags'] as List<dynamic>)
                            .map((tag) => Chip(
                                  backgroundColor: Colors.blue,
                                  label: Text(
                                    '#' + ' ' + tag,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                if (CurrUser.isAdmin! && suggestion['status'] == "pending")
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                      bottom: 50,
                    ),
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: StadiumBorder(),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SuggestionActionScreen(uid: widget.uid),
                            ),
                          );
                        },
                        child: Text('Acknowledge'),
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      color: suggestion['status'] == "approved"
                          ? Color(0xffC1D5CA)
                          : Color(0xffE0BFB8),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          suggestion['status'] == "approved"
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          color: suggestion['status'] == "approved"
                              ? Colors.green
                              : Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          suggestion['status'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: suggestion['status'] == "approved"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                status != 'pending'
                    ? Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.message,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Admin Message:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                suggestion['approvedMessage'],
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TextStyling extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final double? padding;

  TextStyling({
    super.key,
    this.padding,
    this.size = 30,
    required this.text,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: size, fontWeight: FontWeight.bold),
    );
  }
}

class Apptext extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  Apptext(
      {super.key,
      this.size = 16,
      required this.text,
      this.color = Colors.black54});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        // fontWeight: FontWeight.bold
      ),
    );
  }
}
