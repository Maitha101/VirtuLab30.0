// import 'dart:js';
// import 'package:path/path.dart';
// import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/main.dart';

Future<T> onBackPressed<T>(BuildContext context, Widget page) {
  return Navigator.of(context)
      .push<T>(MaterialPageRoute(builder: (context) => page));
} //creates a weird loop

Future<bool> saveDraft(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to save a draft?'),
          actions: <Widget>[
            new GestureDetector(
              child: TextButton(
                  child: Text('Discard'),
                  onPressed: () => Navigator.of(context).pop(true)),
            ),
            new GestureDetector(
                child: TextButton(
                    child: Text('Yes'),
                    onPressed: () => Navigator.of(context).pop(true))),
          ],
        ),
      ) ??
      false;
}

Future<bool> logout(BuildContext context) {
  return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to Logout?'),
          actions: <Widget>[
            new GestureDetector(
              child: TextButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Homepage())),
              ),
            ),
            new GestureDetector(
              child: TextButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(false)),
            ),
          ],
        ),
      ) ??
      false;
}

// void popPage(BuildContext context, Widget page) {
//   return Navigator.of(context).pop();
// }

// class Page2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: new Scaffold(
//         appBar: new AppBar(
//           title: new Text('Page 2'),
//         ),
//         body: new Center(
//           child: new Text('PAGE 2'),
//         ),
//       ),

//     );
//   }
// }
