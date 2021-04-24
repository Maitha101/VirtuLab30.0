import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../functions/database.dart';

class CsStudentAnswers extends StatefulWidget {
  final String csKey;
  final String studKey;
  CsStudentAnswers({this.csKey, this.studKey});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CsStudentAnswers();
  }
}

class _CsStudentAnswers extends State<CsStudentAnswers> {
  Query _studAns;
  Query _csDetails;

  String _title;
  String _description;
  String _body;
  String _q1;
  String _q2;
  String _q3;
  String _q4;
  String _q5;
  String _totalGrade;
  String _deadline;

  String _ans1;
  String _ans2;
  String _ans3;
  String _ans4;
  String _ans5;
  String _date;

  final _gradeForm = GlobalKey<FormState>();
  final _gradeController = TextEditingController();

  void initState() {
    _ans1 = 'Retrieving..';
    _ans2 = 'Retrieving..';
    _ans3 = 'Retrieving..';
    _ans4 = 'Retrieving..';
    _ans5 = 'Retrieving..';
    _date = 'Retrieving..';

    debugPrint(widget.studKey);
    _studAns = firebaseref
        .child('case_study')
        .child(widget.csKey)
        .child('studID')
        .child(widget.studKey);
    // .orderByChild('studID/$_id')
    // .equalTo(_id);

    _csDetails = firebaseref.child('case_study').child(widget.csKey);
    csDetails();
    studAnswes();

    super.initState();
  }

  _validateGrade(String grade) {
    if (grade.isEmpty) {
      return '';
    }
  }

  studAnswes() async {
    DataSnapshot snapshot = await _studAns.once();
    Map ans = snapshot.value;
    setState(() {
      _ans1 = ans['answer1'];
      _ans2 = ans['answer2'];
      _ans3 = ans['answer3'];
      _ans4 = ans['answer4'];
      _ans5 = ans['answer5'];
      _date = ans['date'];
    });
  }

  csDetails() async {
    DataSnapshot snapshot = await _csDetails.once();
    Map csInfo = snapshot.value;
    _title = csInfo['title'];
    _description = csInfo['description'];
    _body = csInfo['body'];
    _q1 = csInfo['question1'];
    _q2 = csInfo['question2'];
    _q3 = csInfo['question3'];
    _q4 = csInfo['question4'];
    _q5 = csInfo['question5'];
    _totalGrade = csInfo['total_grade'];
    _deadline = csInfo['deadline'];
    if (_deadline == "") {
      _deadline = 'No deadline set';
    }
  }

  TextStyle _questionStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle _answerStyle = TextStyle(fontSize: 18, color: Colors.blue[900]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student Answers'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Form(
              key: _gradeForm,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            _title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text('$_description'),
                  ),
                  Divider(color: Colors.grey),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text('$_body'),
                  ),
                  Divider(color: Colors.grey),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('1. $_q1', style: _questionStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(_ans1, style: _answerStyle),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  // Text(_ans1, style: _answerStyle),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('2. $_q2', style: _questionStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(_ans2, style: _answerStyle),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  // Text(_ans2, style: _answerStyle),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('3. $_q3', style: _questionStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(_ans3, style: _answerStyle),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  // Text(_ans3, style: _answerStyle),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('4. $_q4', style: _questionStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(_ans4, style: _answerStyle),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  // Text(_ans4, style: _answerStyle),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Text('5. $_q5', style: _questionStyle),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Text(_ans5, style: _answerStyle),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey),
                  // Text(_ans5, style: _answerStyle),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Container(
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                  'Student: ' + widget.studKey,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                  'Submitted at: ' + _date,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text(
                                  'Deadline: ' + _deadline,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(color: Colors.grey),
                  Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Text(
                            'Grade',
                            style: _questionStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                controller: _gradeController,
                                validator: (value) => _validateGrade(value),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child:
                                  Text('/ $_totalGrade', style: _answerStyle),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Container(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_gradeForm.currentState.validate()) {
                                  firebaseref
                                      .child('case_study')
                                      .child(widget.csKey)
                                      .child('studID')
                                      .child(widget.studKey)
                                      .child('grade')
                                      .set(_gradeController.text);
                                  firebaseref
                                      .child('case_study')
                                      .child(widget.csKey)
                                      .child('studID')
                                      .child(widget.studKey)
                                      .update({'graded': 'true'});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Grade Submitted Successfully'),
                                      backgroundColor:
                                          Colors.deepPurple, //change?
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text('Upload Grade'),
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
