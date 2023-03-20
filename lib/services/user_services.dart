import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUser(UserModel user) {
    return _db.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<UserModel?> getUser(String email) async {
    final snapshot = await _db.collection('users').doc(email).get();
    if (snapshot.exists) {
      return UserModel(
        username: snapshot.get('username'),
        prn: snapshot.get('prn'),
        email: snapshot.get('email'),
        password: snapshot.get('password'),
        mobile: snapshot.get('mobile'),
        image: snapshot.get('image'),
        uid: snapshot.get('uid'),
      );
    }
    return null;
  }
}
