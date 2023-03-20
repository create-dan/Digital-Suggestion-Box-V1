// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/helper/validators.dart';

import 'package:dss/models/suggestion_model.dart';
import 'package:dss/widgets/my_bottom.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuggestionActionScreen extends StatefulWidget {
  final String uid;

  const SuggestionActionScreen({super.key, required this.uid});

  @override
  State<SuggestionActionScreen> createState() => _SuggestionActionScreenState();
}

class _SuggestionActionScreenState extends State<SuggestionActionScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  late SuggestionModel suggestion;
  String? _status;

  @override
  void initState() {
    super.initState();
    _getStatus();
  }

  void _getStatus() async {
    // final suggestionDoc = await SuggestionModel.doc(uid).get();
    // final suggestion = SuggestionModel.fromJson(suggestionDoc.data());

    final DocumentSnapshot<Map<String, dynamic>> suggestionDoc =
        await FirebaseFirestore.instance
            .collection('suggestions')
            .doc(widget.uid)
            .get();
    setState(() {
      suggestion = SuggestionModel.fromJson(suggestionDoc.data()!);
    });
  }

  Future<void> _updateStatus() async {
    await FirebaseFirestore.instance
        .collection('suggestions')
        .doc(widget.uid)
        .update({'status': _status, 'approvedMessage': messageController.text});
    // Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyBottom()),
    );

    String snackBarMessage = _status == "approved"
        ? "Suggestion approved successfully!"
        : "Suggestion discarded successfully!";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              snackBarMessage,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggestion Action'),
      ),
      body: suggestion == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      child: Lottie.network(
                        'https://assets3.lottiefiles.com/packages/lf20_ctvgysft.json',
                        repeat: false,
                        reverse: true,
                        animate: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        suggestion.title,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(38.0),
                      child: DropdownButtonFormField<String>(
                        value: _status,
                        hint: Text('Please select a status'),
                        onChanged: (String? value) {
                          setState(() {
                            _status = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'approved',
                            child: Text('Approved'),
                          ),
                          DropdownMenuItem(
                            value: 'discard',
                            child: Text('Discard'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        // vertical: 10,
                      ),
                      child: TextFormField(
                        controller: messageController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          label: Text("What Changes are taken ?"),
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: messageRequireValidator,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     if (_formKey.currentState!.validate()) {
                    //       _updateStatus();
                    //     }
                    //   },
                    //   child: Text('Submit'),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _updateStatus();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(
                              17, 99, 180, 1), // set background color
                          minimumSize:
                              Size(double.infinity, 50), // set width to 100%
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8), // add padding
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
