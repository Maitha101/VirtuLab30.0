
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';
import 'instructorNavBar.dart';

String
    courseKey; // << -- glabal key that has course key ((taken from course select))

class MainInstructor extends StatelessWidget {
  final String
      cKey; // <<--- initialize ckey to recieve course key from course select
  MainInstructor({this.cKey});

  @override
  Widget build(BuildContext context) {
    courseKey = cKey; //<< -- global coursekey == cKey
    return MaterialApp(title: 'Instructor', home: InstructorNavBar());
  }
}

class InstReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstReport();
  }
}

class _InstReport extends State<InstReport> {
  Query _query ;
  bool check = false ;
  @override
  void initState() {
    super.initState();
    _query = firebaseref
        .child('case_study')
        .orderByChild('course_id')
        .equalTo(courseKey);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Report Summary'),
          backgroundColor: Colors.deepPurple,
        ),
        body:Container(
          child: FirebaseAnimatedList(
              query: firebaseref
                  .child('case_study')
                  .orderByChild('course_id')
                  .equalTo(courseKey),
              itemBuilder: (BuildContext context, snapshot,
                  Animation<double> animation, int index) {
                Map caseStudy1 = snapshot.value;
                caseStudy1['key'] = snapshot.key;
                return caseStudyInfo(caseStudy: caseStudy1);
              }),
        ));
  }

  caseStudyInfo({Map caseStudy}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
      child: Card(
        elevation: 10,
        shadowColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: caseStudy['title'],
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 5,),
                Container(
                  height: 170,
                  child: FirebaseAnimatedList(
                    query: firebaseref.child('case_study').child(caseStudy['key']).child('studID').orderByChild('answer1'),
                    itemBuilder: (BuildContext context, snapshot,
                    Animation<double> animation, int index){
                      Map student = snapshot.value;
                      student['key'] = snapshot.key;
                      return getStudentCase(student: student);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getStudentCase({Map student}){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Student ID: " +student['key'] + "\nSubmit Case Study",
                  fontSize: 19,
                ),
                CustomText(text: "Date : "+student['date'],)
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: student['graded'] == "true" ? Colors.blue : Colors.red,
                borderRadius: BorderRadius.circular(30)
              ),
              child: CustomText(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                text: student['graded'] == "true" ? "Graded" : "Not Graded",
              ),
            )
          ],
        ),
      ),
    );
  }
}
