import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/instructor/inst_create_course.dart';
import 'package:virtulab/instructor/inst_report.dart';
import 'inst_create_course.dart';

class InstCourseSelect extends StatefulWidget {
  @override
  _InstCourseSelectState createState() => _InstCourseSelectState();
}

class _InstCourseSelectState extends State<InstCourseSelect> {
  bool _progressController = true;
  Query dbRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _progressController =
          false; // can be used when waiting for firebase stuff
    });
// exception handel
    try{
      dbRef = firebaseref
          .child('course')
          .orderByChild('instID')
          .equalTo(getCurrentID());
    }
    catch(e){
      print(e.toString());
    }
  }

  Widget _buildCourseList({Map course}) {
    return _progressController
        ? CircularProgressIndicator()
        : InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
              child: Card(
                elevation: 10,
                shadowColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  height: 130,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            course['name'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            course['code'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepPurple),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'instructor: ' + course['instname'], //'instructor name',
                        //course['description'],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //MainInstructor()
                  //InstructorNavBar()
                  builder: (BuildContext context) => MainInstructor(
                    cKey: course['key'],
                  ),
                ),
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CreateCourse(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Course Selection'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
          query: dbRef,
          defaultChild: Center(child: CircularProgressIndicator()),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map course = snapshot.value;
            course['key'] = snapshot.key;
            return _buildCourseList(course: course);
          },
        ),
      ),
    );
  }
}
