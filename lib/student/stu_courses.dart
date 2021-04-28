import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'stu_course_contents.dart';
import 'package:virtulab/student/stu_course_register.dart';

class StudentCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentCourses();
  }
}

class _StudentCourses extends State<StudentCourses> {
  Query _courses;
  String _instName = 'Retrieving..';
  String _instID;
  String _id = getCurrentID();

  initState() {
    super.initState();
    // exception handel
    try{
      _courses =
          firebaseref.child('course').orderByChild('studID/$_id').equalTo(_id);
    }
    catch(e){
      print(e.toString());
    }
  }

  getInstName(String id) async {
    try{
      DataSnapshot snapshot =
      await firebaseref.child('instructor').child(id).once();
      Map inst = snapshot.value;
      setState(() {
        _instName = inst['fname'] + ' ' + inst['lname'];
      });
    }
    catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddCourseButton(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Courses'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FirebaseAnimatedList(
        query: _courses,
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index) {
          Map _courses = snapshot.value;
          _courses['key'] = snapshot.key;
          // _courses['instID'] = getInstName(_courses['instID']);

          return _courseList(courseList: _courses);
        },
      ),
    );
  }

  Widget _courseList({Map courseList}) {
    // _instID = courseList['instID'];
    print(courseList.length);
    if (courseList.isEmpty) {
      return Center(child: Text('You are not registered to any course'));
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 8),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 10,
              shadowColor: Colors.deepPurple,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => StudentCourseContents(
                        cKey: courseList['key'], //<<-- was missing
                        courseName: courseList['name']),
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
                                Icon(Icons.auto_stories),
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
}

class AddCourseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => StuCourseRegister(),
        ),
      ),
      icon: Icon(Icons.add),
      label: Text(
        "Add New Course",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.amber,
    );
  }
}
