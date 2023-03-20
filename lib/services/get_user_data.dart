// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dss/models/user_model.dart';
import 'package:dss/widgets/my_bottom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatelessWidget {
  const GetUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    String documentId = uid;
    // print('GetStudentData');
    // print("Uid $documentId");

    String collectionName = "users";

    CollectionReference users =
        FirebaseFirestore.instance.collection(collectionName);

    // print(users.id);

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong, Please try again'),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            // print("data");
            // print(data);

            CurrUser.username = data['username'].toString();
            CurrUser.prn = data['prn'].toString();
            CurrUser.email = data['email'].toString();
            CurrUser.password = data['password'].toString();
            CurrUser.mobile = data['mobile'].toString();
            CurrUser.image = data['image'].toString();
            CurrUser.uid = data['uid'].toString();
            CurrUser.isAdmin = data['isAdmin'];

            // UserModel.password = data['Info']['password'].toString();

            // if (auth.currentUser!.emailVerified) {
            //   if (UserModel.branch == "" || UserModel.branch == null) {
            //     return StudentProfileSetup();
            //   }
            // } else {
            //   return VerifyUserScreen();
            // }
            // return HomePage();

            return MyBottom();
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.red),
          );
        },
      ),
    );
  }
}
