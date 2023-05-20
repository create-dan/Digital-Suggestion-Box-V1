// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
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
  final List<String> items = [
    'Hygiene',
    'Food quality',
    'Unavailability',
    'Taste',
    'Costly',

  ];
  String? selectedValue;

  TextEditingController tagController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  final GlobalKey<FormState> _formFieldKey = GlobalKey();
  bool isAnonymous = false;
  String description = '';
  String tag = '';
  List<String> tags = [];
  //
  // void _addTag() {
  //   if (tag.isNotEmpty) {
  //     setState(() {
  //       tags.add(tag);
  //       tag = '';
  //       tagController.text = '';
  //     });
  //   }
  // }

  void _addTag() {
    if (tag.isNotEmpty) {
      setState(() {
        tags.add(tag);
        tag = '';
        tagController.text = '';
      });
    }
    // if (selectedValue != null && selectedValue!.isNotEmpty) {
    //   setState(() {
    //     tags.add(selectedValue!);
    //     selectedValue = null;
    //   });
    // }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Suggestion',
          ),
          backgroundColor: Color(0xff05BFDB),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                    Icon(Icons.tag, color: Color(0xff7687db)),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 7,bottom:2),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select Tags',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: items
                                      .map((value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,

                                  // controller: tagController,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                      tags.add(selectedValue!); // Add the selected tag to the tags array
                                      selectedValue = null; // Reset the selectedValue
                                    });
                                  },

                                  buttonStyleData: const ButtonStyleData(
                                    height: 40,
                                    width: 120,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: _addTag,
                          icon: Icon(Icons.add, color: Colors.white),
                          label: Text('Add',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff7687db)),
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
                    SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff7687db)),
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
