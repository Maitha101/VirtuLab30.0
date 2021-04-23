
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtulab/functions/auth.dart';

import '../functions/database.dart';

class CreateCourse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CreateCourse();
  }
}

_validator(String value) {
  if (value.isEmpty) {
    return '* Required';
  }
}

class _CreateCourse extends State<CreateCourse> {
  final dbRef = FirebaseDatabase.instance.reference().child('course');
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _descController = TextEditingController();
  String _fullName = '';

  initState(){
    super.initState();
    getInstName();
  }
  getInstName() async {
      DataSnapshot snapshot =
          await firebaseref.child('instructor').child(getCurrentID()).once();
      Map inst = snapshot.value;
      setState(() {
        _fullName = inst['fname'] + ' ' + inst['lname'];
      });
    }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text('New'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.yellow[700],
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create Course'),
                content: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: TextFormField(
                                  validator: (value) => _validator(value),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Course Name',
                                  ),
                                  controller: _nameController,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: TextFormField(
                                  validator: (value) => _validator(value),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Course Code',
                                  ),
                                  controller: _codeController,
                                ),
                              ),
                            ),
                            // Flexible(
                            //   child: Padding(
                            //     padding: EdgeInsets.all(2.0),
                            //     child: TextFormField(
                            //       validator: (value) => _validator(value),
                            //       decoration: InputDecoration(
                            //         border: OutlineInputBorder(),
                            //         labelText: 'Description',
                            //       ),
                            //       controller: _descController,
                            //     ),
                            //   ),
                            // ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.deepPurple)),
                                  child: Text('Create'),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      dbRef.push().set({
                                        'name': _nameController.text,
                                        'instID': getCurrentID(),
                                        'instname': _fullName,
                                        'code': _codeController.text,
                                        // 'description': _descController.text,
                                      });
                                      _nameController.clear();
                                      _codeController.clear();
                                      _descController.clear();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      },
    );
  }
}

