import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/screens/NoSuggestion.dart';
import 'package:dss/screens/SingleSuggestion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RenderAllSuggestions extends StatefulWidget {
  const RenderAllSuggestions({Key? key}) : super(key: key);

  @override
  State<RenderAllSuggestions> createState() => _RenderAllSuggestionsState();
}

class _RenderAllSuggestionsState extends State<RenderAllSuggestions> {
  String searchText = '';

  TextEditingController searchController = TextEditingController();
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void hideKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    searchFocusNode.unfocus();
  }

  void onSearchTextChanged(String value) {
    setState(() {
      searchText = value;
    });
    if (value.isEmpty) {
      hideKeyboard();
    }
  }

  Stream<List<SuggestionModel>> getAllSuggestions() {
    CollectionReference collection = FirebaseFirestore.instance.collection('suggestions');
    Query query;

    // Check if the user is an admin
    if (CurrUser.isAdmin!) {
      query = collection.orderBy('createdAt', descending: true);
    } else {
      // Get suggestions for the current user
      query = collection
          .where('ownerUid', isEqualTo: CurrUser.uid)
          .orderBy('createdAt', descending: true);
    }

    return query.snapshots().map((querySnapshot) => querySnapshot.docs.map((documentSnapshot) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      return SuggestionModel.fromJson(data);
    }).toList());
  }

  List<SuggestionModel> filterSuggestions(List<SuggestionModel> suggestions) {
    if (searchText.isEmpty) {
      return suggestions;
    }
    return suggestions.where((suggestion) => suggestion.tags.contains(searchText)).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        hideKeyboard();
        return true;
      },
      child: GestureDetector(
        onTap: hideKeyboard,
        child: Scaffold(
          backgroundColor: Color(0xffEFF5F5),
          appBar: AppBar(
            backgroundColor: Color(0xff05BFDB),
            title: CurrUser.isAdmin!
                ? Text(
              'All Suggestions',
              style: TextStyle(
                color: Colors.black,
              ),
            )
                : Text(
              'Track My Suggestions',
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
                  if (CurrUser.isAdmin!)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: searchController,
                        focusNode: searchFocusNode,
                        decoration: InputDecoration(
                          labelText: "Search",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: onSearchTextChanged,
                      ),
                    ),
                  StreamBuilder<List<SuggestionModel>>(
                    stream: getAllSuggestions(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<SuggestionModel> suggestions = snapshot.data!;
                        List<SuggestionModel> filteredSuggestions = filterSuggestions(suggestions);
                        if (filteredSuggestions.isEmpty) {
                          return NoSuggestionsScreen();
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredSuggestions.length,
                              itemBuilder: (context, index) {
                                SuggestionModel suggestion = filteredSuggestions[index];
                                return SingleSuggestion(
                                  suggestion: suggestion,
                                  uid: suggestion.uid,
                                );
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
        ),
      ),
    );
  }
}
