// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/helper/validators.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/screens/add_suggestion_image.dart';
import 'package:dss/services/suggestion_helper.dart';
import 'package:flutter/material.dart';

class AddSuggestionDesc extends StatefulWidget {
  @override
  _AddSuggestionDescState createState() => _AddSuggestionDescState();
}

class _AddSuggestionDescState extends State<AddSuggestionDesc> {
  TextEditingController tagController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  final GlobalKey<FormState> _formFieldKey = GlobalKey();
  bool isAnonymous = false;
  String description = '';
  String tag = '';
  List<String> tags = [];

  void _addTag() {
    if (tag.isNotEmpty) {
      setState(() {
        tags.add(tag);
        tag = '';
        tagController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Suggestion',
          ),
          backgroundColor: Color(0xffff13005A),
          leading: Icon(Icons.data_saver_on_sharp),
        ),
        body: SafeArea(
          // bottom: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formFieldKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Post as',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: isAnonymous,
                          onChanged: (value) {
                            setState(() {
                              isAnonymous = value!;
                            });
                          },
                        ),
                        Text('Anonymous'),
                        Radio(
                          value: false,
                          groupValue: isAnonymous,
                          onChanged: (value) {
                            setState(() {
                              isAnonymous = value!;
                            });
                          },
                        ),
                        Text('Not-Anonymous'),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: messageRequireValidator,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Enter your suggestion description',
                        border: OutlineInputBorder(),
                      ),
                      validator: messageRequireValidator,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Tags',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Wrap(
                      spacing: 8,
                      children: tags
                          .map(
                            (t) => InputChip(
                              label: Text(t),
                              onDeleted: () {
                                setState(() {
                                  tags.remove(t);
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 8),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Expanded(
                    //       child: TextField(
                    //         controller: tagController,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             tag = value;
                    //           });
                    //         },
                    //         decoration: InputDecoration(
                    //           hintText: 'Enter tag',
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 8),
                    //     ElevatedButton(
                    //       onPressed: _addTag,
                    //       child: Text('Add'),
                    //     ),
                    //   ],
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Expanded(
                    //       child: TextField(
                    //         controller: tagController,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             tag = value;
                    //           });
                    //         },
                    //         decoration: InputDecoration(
                    //           hintText: 'Enter tag',
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide(
                    //               color: Colors.grey.shade300,
                    //               width: 2,
                    //             ),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //             borderSide: BorderSide(
                    //               color: Colors.blue,
                    //               width: 2,
                    //             ),
                    //           ),
                    //           filled: true,
                    //           fillColor: Colors.grey.shade100,
                    //           contentPadding: EdgeInsets.symmetric(
                    //               vertical: 10, horizontal: 15),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 8),
                    //     ElevatedButton(
                    //       onPressed: _addTag,
                    //       style: ButtonStyle(
                    //         backgroundColor:
                    //             MaterialStateProperty.all<Color>(Colors.blue),
                    //         foregroundColor:
                    //             MaterialStateProperty.all<Color>(Colors.white),
                    //         shape:
                    //             MaterialStateProperty.all<RoundedRectangleBorder>(
                    //           RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(10),
                    //           ),
                    //         ),
                    //         padding: MaterialStateProperty.all<EdgeInsets>(
                    //           EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    //         ),
                    //       ),
                    //       child: Text('Add'),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 16),
                                Icon(Icons.tag, color: Color(0xffEB455F)),
                                SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    controller: tagController,
                                    onChanged: (value) {
                                      setState(() {
                                        tag = value;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Enter tag',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _addTag,
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('Add',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffEB455F)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffEB455F)),
                          ),
                          onPressed: () async {
                            if (_formFieldKey.currentState!.validate()) {
                              await SuggestionHelper()
                                  .addSuggestion(
                                SuggestionModel(
                                  uid: "",
                                  username: isAnonymous
                                      ? ""
                                      : CurrUser.username.toString(),
                                  isAdmin: false,
                                  status: "pending",
                                  title: titleController.text,
                                  upvotes: 10,
                                  isAnonymous: isAnonymous,
                                  description: descriptionController.text,
                                  tags: tags,
                                  imageUrl: "imageUrl",
                                  ownerUid: isAnonymous
                                      ? ""
                                      : CurrUser.uid.toString(),
                                  createdAt: Timestamp.now(),
                                ),
                              )
                                  .then((value) async {
                                return Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddSuggestionImage(
                                          suggestionUid: value)),
                                );
                              });
                            }
                          },
                          child: Text('Next'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
