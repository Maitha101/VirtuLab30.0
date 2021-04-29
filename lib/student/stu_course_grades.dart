import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';
import '../functions/auth.dart';

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
  List total = [];
  Query _csGrade;
  String _grade;
  String myID = getCurrentID();
  double totalGrade = 0;

  bool check = false;

  initState() {
    String cId_false = widget.courseID + 'false';
    super.initState();
    // exception handel
    try {
      _csGrade = firebaseref
          .child('case_study')
          .orderByChild('cID_draft')
          .equalTo(cId_false);
    } catch (e) {
      print(e.toString());
    }
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
                    child: check == false
                        ? Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      width: 180,
                            height: 60,
                            child: TextButton(
                            onPressed: () {
                              setState(() {
                                getTotalGrade();
                                check = true;
                              });
                            },
                            child: CustomText(
                              text: "Get Total",
                              fontSize: 20,
                            )),
                          ),
                        )
                        : Container(
                      height: 60,
                      width: 160,
                      margin: EdgeInsets.fromLTRB(40, 0, 40, 10),
                      decoration: new BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius:
                            new BorderRadius.all(Radius.elliptical(50, 50)),
                      ),
                      child:Center(
                              child: Text(
                              "$totalGrade",
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
                    trailing: Container(
                      height: 35,
                      width: 70,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 3.5,left: 5),
                              height: 30,
                              width: 30,
                              child: FirebaseAnimatedList(
                                  query: firebaseref
                                      .child('case_study')
                                      .child(gradesList['key'])
                                      .child('studID')
                                      .orderByChild(myID)
                                      .equalTo(myID),
                                  itemBuilder: (BuildContext context,
                                      snapshot,
                                      Animation<double> animation,
                                      int index) {
                                    Map _myGrade = snapshot.value;
                                    _myGrade['key'] = snapshot.key;
                                    return myGrade(myGrade: _myGrade);
                                  })),
                          SizedBox(
                            width: 5,
                          ),
                          Text("/" + gradesList['total_grade'],style: TextStyle(fontSize: 19),),
                        ],
                      ),
                    ),
                  ),
                  Divider(thickness: 2),
                ])),
          ]))
    ]);
  }

  myGrade({Map myGrade}) {
    total.add(myGrade['grade'] == 'not_graded' ? "0" : myGrade['grade']);
    print(total);
    return Container(
      child: CustomText(
        text: myGrade['grade'] == "not_graded" ? "---" : myGrade['grade'],
        fontSize: 20,
      ),
    );
  }

  getTotalGrade() {
    for (int x = 0; x < total.length; x++) {
      totalGrade += double.parse(total[x]);
      print(totalGrade);
      print(total.length);
    }
    total.clear();
    return totalGrade.toString();
  }
}

// Text(
// gradesList['studID'][getCurrentID()]['grade'] == null
// ? "-" + "/" + gradesList['total_grade']
// : gradesList['studID'][getCurrentID()]['grade'] +
// "/" +
// gradesList['total_grade']),
// )
