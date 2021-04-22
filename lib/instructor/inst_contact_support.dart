import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';

class InstContactSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InstContactSupport();
  }
}

TextStyle _textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

// InputDecoration _inputDecor = InputDecoration(
//   border: OutlineInputBorder(),
// );

class _InstContactSupport extends State<InstContactSupport> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _support = GlobalKey<FormState>();
  String instName;
  String id = getCurrentID();

  @override
  void initState() {
    getInstName();
    debugPrint(instName);
    super.initState();
  }

  getInstName() async {
    String id = getCurrentID();
    DataSnapshot snapshot = await firebaseref
        .child('instructor')
        .orderByChild('ID')
        .equalTo(id)
        .once();
    Map inst = snapshot.value;
    setState(() {
      instName = inst['fname'];
    });
  }

  _contactSupportMessage(String subject, String message) {
    // getCurrentUser();
    var date = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy - hh:mm a').format(date);
    String status = 'new';
    firebaseref.child('tech_support').push().set({
      'senderID': getCurrentID(), //'someones id',//id.toString(),
      'senderName': instName,
      'subject': subject,
      'message': message,
      'date': formattedDate, //date.toString(),
      'status': status,
    });
  }

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
