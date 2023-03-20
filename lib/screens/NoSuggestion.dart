// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoSuggestionsScreen extends StatelessWidget {
  const NoSuggestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(
            'https://assets3.lottiefiles.com/packages/lf20_zi2xpiyh.json',
            repeat: false,
          ),
          Text(
            "You don't have any suggestions yet.",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
