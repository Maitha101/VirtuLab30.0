// import 'dart:js';
// import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart'; //search bar
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import '../functions/database.dart';

class StuCourseRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StuCourseRegister();
  }
}

class _StuCourseRegister extends State<StuCourseRegister> {
  Query allCourses;
  Query instName;
  bool _progressController = true;
  String _name = 'Retrieving..';
  String _instID;
  void initState() {
    super.initState();
    setState(() {
      // allCourses = firebaseref.child('course').orderByChild('name');
      // instName = firebaseref.child('instructor').orderByChild('ID');
      _progressController = false;
    });
    allCourses = firebaseref.child('course').orderByChild('name');
    instName = firebaseref.child('instructor'); //.orderByChild('ID');
    getInstName(_instID); // is ok only when async?
  }

  registerStudent(String courseKey) {
    firebaseref
        .child('course')
        .child(courseKey)
        .child('studID')
        .child(getCurrentID())
        .set(getCurrentID());
  }

  getInstName(String id) async {
    DataSnapshot snapshot =
        await firebaseref.child('instructor').child(id).once();
    Map inst = snapshot.value;
    setState(() {
      _name = inst['fname'] + ' ' + inst['lname'];
    });
  }

  confirmation(String key) {
    showDialog(
      context: this.context,
      builder: (cxt) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to register to this course?'),
        actions: <Widget>[
          TextButton(
              child: Text('Yes'),
              onPressed: () {
                registerStudent(key);
                Navigator.of(cxt).pop(); // closes alert dialog
                ScaffoldMessenger.of(this.context).showSnackBar(
                  SnackBar(
                    content: Text('Registered to course successfully'),
                    backgroundColor: Colors.deepPurple, //change?
                  ),
                );
                Navigator.pop(this.context); // takes to previos page
              }),
          TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(cxt).pop();
              }),
        ],
      ),
    );
  }

  Widget courseList({Map courseList}) {
    return Card(
      child: InkWell(
        onTap: () => confirmation(courseList['key']),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          // height: 70,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: [
              Text(
                courseList['name'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              SizedBox(height: 5),
              Text('Code: ' + courseList['code'],
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
              // ],
              // ),
              SizedBox(height: 5),
              Text(
                'Instructor: ' +
                    _name, //getInstName(courseList['instID']).toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Course Register'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        // child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FirebaseAnimatedList(
            query: allCourses,
            defaultChild: Center(child: CircularProgressIndicator()),
            itemBuilder: (BuildContext context, snapshot,
                Animation<double> animation, int index) {
              Map _courses = snapshot.value;
              _courses['key'] = snapshot.key;

              // _courses['instID'] = _name;
              return courseList(courseList: _courses); //, instName: _instName);
            },
          ),
        ),
        // ),
      ),
    );
  }
}
