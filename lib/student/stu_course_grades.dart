import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_course_contents.dart';

class CourseGrades extends StatefulWidget {
  final String courseName;
  final String courseID;
  CourseGrades({this.courseName, this.courseID});
  @override
  State<StatefulWidget> createState() {
    return _CourseGrades();
  }
}

class _CourseGrades extends State<CourseGrades> {
  Query _csGrade;
  Query _studGrade;
  String _grade;

  initState() {
    String cId_false = widget.courseID + 'false';
    super.initState();
    _csGrade = firebaseref
        .child('case_study')
        .orderByChild('cID_draft')
        .equalTo(cId_false);
    _studGrade =
        firebaseref.child('case_study').child('studID').child(getCurrentID());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.courseName),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(children: <Widget>[
          getTotal(),
          Flexible(
            child: FirebaseAnimatedList(
              query: _csGrade,
              defaultChild: Center(child: CircularProgressIndicator()),
              itemBuilder: (BuildContext context, snapshot,
                  Animation<double> animation, int index) {
                Map _grade = snapshot.value;
                _grade['key'] = snapshot.key;
                return _gradesList(gradesList: _grade);
              },
            ),
          )
        ]));
  }

  Widget getTotal({Map total}) {
    return Column(children: <Widget>[
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    )),
                  ),
                  Align(
                    child: Container(
                      height: 60,
                      width: 160,
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
                      decoration: new BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            new BorderRadius.all(Radius.elliptical(50, 50)),
                      ),
                      child: Center(
                          child: Text(
                        'Pending',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      )), //Temp data
                    ),
                  ),
                  Divider(thickness: 2),
                ]))
          ]))
    ]);
  }

//sasasas
  Widget _gradesList({Map gradesList}) {
    return Column(children: <Widget>[
      Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  ListTile(
                    title: Text(
                      gradesList['title'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 2,
                          color: Colors.deepPurple),
                    ),
                    trailing: Text(
                        /*gradesList['grade']+*/ '/' +
                            gradesList['total_grade']),
                  ),
                  Divider(thickness: 2),
                ]))
          ]))
    ]);
  }
}
