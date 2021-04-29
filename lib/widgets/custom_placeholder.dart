import 'package:flutter/material.dart';
import 'package:virtulab/widgets/custom_text.dart';

class CustomPlaceHolder extends StatelessWidget {
  final String message;
  CustomPlaceHolder({this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 250,
              width: 250,
              child: Image.asset("assets/images/empty_placeholder.png")),
          CustomText(
            text: message,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
