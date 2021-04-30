import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../../functions/database.dart';
import 'inst_student_cs_answers.dart';

class CsStudentSelect extends StatefulWidget {
  final String snapshotKey;
  CsStudentSelect({this.snapshotKey});
  @override
  State<StatefulWidget> createState() {
    return _CsStudentSelect();
  }
}

class _CsStudentSelect extends State<CsStudentSelect> {
  Query _caseStudy;
  Query _studInfo;
  String fullName;
  String _studID = '1234567890';

  // exception handel
  void initState() {
    super.initState();
    try{
      _caseStudy = firebaseref
          .child('case_study')
          .child(widget.snapshotKey)
          .child('studID')
          .orderByChild('graded')
          .equalTo('false');
      _studInfo = firebaseref.child('student');
    }
    catch(e){
      print(e.toString());
    }

    studName(_studID);
  }

  studName(String id) async {
    DataSnapshot snapshot = await _studInfo.reference().child(id).once();
    Map student = snapshot.value;
    fullName = student['fname'] + ' ' + student['lname'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student Submissions'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FirebaseAnimatedList(
          query: _caseStudy,
          defaultChild: Center(child: CircularProgressIndicator()),
          itemBuilder: (BuildContext context, snapshot,
              Animation<double> animation, int index) {
            Map _cs = snapshot.value;
            _cs['key'] = snapshot.key;
            return studentList(studList: _cs);
          }),
    );
  }

  studentList({Map studList}) {
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CsStudentAnswers(
                    csKey: widget.snapshotKey, studKey: studList['key'])));
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Student ID',
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Text(studList['key'],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
