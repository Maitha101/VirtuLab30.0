import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';

_contactSupportMessage(String subject, String message) async {
  // getCurrentUser();
  var date = DateTime.now();
  String formattedDate = DateFormat('DD/MM/YYYY - hh:mm a').format(date);
  String status = 'new';
  firebaseref.child('tech_support').push().set({
    'senderID': getCurrentID(), //'someones id',//id.toString(),
    'subject': subject,
    'message': message,
    'date': formattedDate, //date.toString(),
    'status': status,
  });
}

class ContactSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ContactSupport();
  }
}

TextStyle _textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

// InputDecoration _inputDecor = InputDecoration(
//   border: OutlineInputBorder(),
// );

class _ContactSupport extends State<ContactSupport> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _support = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact Support'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Form(
          key: _support,
          child: ListView(
            children: [
              Column(
                children: [
                  Text(
                    'Message',
                    style: _textStyle,
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    //title
                    controller: _subjectController,
                    validator: (String sub) {
                      if (sub.toString().isEmpty) {
                        return '* Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Subject'),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    //body
                    controller: _messageController,
                    validator: (String message) {
                      if (message.toString().isEmpty) {
                        return '* Required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Message',
                      alignLabelWithHint: true,
                    ),
                    maxLength: 500,
                    minLines: 10,
                    maxLines: null,
                  ),
                  SizedBox(height: 25),
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_support.currentState.validate()) {
                          _contactSupportMessage(
                              _subjectController.text, _messageController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Message successfully sent'),
                              backgroundColor: Colors.deepPurple, //change?
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Send',
                        // style: textStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
