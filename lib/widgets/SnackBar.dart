// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class CustomSnackbar extends StatelessWidget {
  final String message;

  CustomSnackbar({required this.message});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.green,
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white),
          SizedBox(width: 10),
          Text(
            message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
