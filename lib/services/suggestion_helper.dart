import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/data/data.dart';
import 'package:dss/models/suggestion_model.dart';
import 'package:dss/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SuggestionHelper {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> addSuggestion(SuggestionModel suggestion) {
    return _db
        .collection('suggestions')
        .add(suggestion.toJson())
        .then((value) async {
      await _db
          .collection('suggestions')
          .doc(value.id)
          .update({'uid': value.id});

      return value.id;
    });
  }

  Future<SuggestionModel?> getSuggestion(String uid) async {
    final snapshot = await _db.collection('suggestions').doc(uid).get();
    if (snapshot.exists) {
      return SuggestionModel(
        title: snapshot.get('title'),
        username: snapshot.get('username'),
        isAdmin: snapshot.get('isAdmin'),
        status: snapshot.get('status'),
        upvotes: snapshot.get('upvotes'),
        isAnonymous: snapshot.get('isAnonymous'),
        description: snapshot.get('description'),
        tags: snapshot.get('tags'),
        imageUrl: snapshot.get('imageUrl'),
        ownerUid: snapshot.get('ownerUid'),
        createdAt: snapshot.get('createdAt'),
        uid: snapshot.get('uid'),
      );
    }
    return null;
  }
}
