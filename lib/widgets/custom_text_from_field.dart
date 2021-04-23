// Maitha Page

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Function onChange;
  CustomTextFormField({this.hintText,this.onChange});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 19,color: Colors.black),
      onChanged: onChange,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18),
          border: OutlineInputBorder()
      ),
    );
  }
}
