// ignore_for_file: prefer_const_constructors

import 'package:dss/models/suggestion_model.dart';
import 'package:flutter/material.dart';

class MySuggestionCard extends StatefulWidget {
  SuggestionModel? suggestion;
  MySuggestionCard({Key? key, required this.suggestion}) : super(key: key);

  @override
  State<MySuggestionCard> createState() => _MySuggestionCardState();
}

class _MySuggestionCardState extends State<MySuggestionCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.suggestion!.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.suggestion!.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.thumb_up_alt),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.edit,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
