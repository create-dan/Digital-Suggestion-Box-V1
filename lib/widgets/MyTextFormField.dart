import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String name;
  final Function onChange;
  const MyTextFormField({Key? key, required this.name, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: name,
            border: OutlineInputBorder(),
          ),
          onChanged: onChange(),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
