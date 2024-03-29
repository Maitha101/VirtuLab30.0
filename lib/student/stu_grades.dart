import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_course_grades.dart';
import 'package:virtulab/widgets/custom_placeholder.dart';

class StudentGrades extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentGrades();
  }
}

class _StudentGrades extends State<StudentGrades> {
  Query _courses;
  String _id = getCurrentID();
  bool check;
  initState() {
    super.initState();
    // exception handel
    try {
      _courses =
          firebaseref.child('course').orderByChild('studID/$_id').equalTo(_id);
      _courses.once().then((DataSnapshot snapshot) => {
            if (snapshot.value == null) {check = false} else {check = true}
          });
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      Timer(Duration(seconds: 0), () {
        setState(() {
          print(check);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Grades'),
        backgroundColor: Colors.deepPurple,
      ),
      body: check == false
          ? CustomPlaceHolder(
              message: "You Have No Grades Yet!",
            )
          : FirebaseAnimatedList(
              query: _courses,
              defaultChild: Center(child: CircularProgressIndicator()),
              itemBuilder: (BuildContext context, snapshot,
                  Animation<double> animation, int index) {
                Map _courses = snapshot.value;
                _courses['key'] = snapshot.key;

                return _courseList(courseList: _courses);
              },
            ),
    );
  }

  _courseList({Map courseList}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 10,
            shadowColor: Colors.deepPurple,
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CourseGrades(
                    courseName: courseList['name'],
                    courseID: courseList['key'],
                  ),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.grading,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    courseList['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        height: 2,
                                        color: Colors.deepPurple),
                                  ),
                                  Text(
                                    'Instructor: ' + courseList['instname'],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_rounded),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
