import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:virtulab/Model/stu_case_study_model.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';

class CaseStudyView extends StatefulWidget {
  final String csKey;
  final String caseStudyName;

  CaseStudyView({this.csKey, this.caseStudyName});

  @override
  State<StatefulWidget> createState() {
    return _CaseStudyView();
  }
}

class _CaseStudyView extends State<CaseStudyView> {
  List<CaseStudyModel> caseStudyList = [];
  String title;
  String description;
  String body;
  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  DatabaseReference _ref;

  final _formKey = GlobalKey<FormState>();
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();

  DatabaseReference caseStudyInfo;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('case_study');
    getCaseStudyDetails();
    caseStudyInfo = firebaseref.child('case_study');
    caseStudyInfo.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      caseStudyList.clear();
      for (var key in keys) {
        CaseStudyModel csList = new CaseStudyModel(
          data[key]['title'],
          data[key]['description'],
          data[key]['body'],
          data[key]['question1'],
          data[key]['question2'],
          data[key]['question3'],
          data[key]['question4'],
          data[key]['question5'],
        );
        caseStudyList.add(csList);
      }

      setState(() {
        print('Length : $caseStudyList.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.caseStudyName,
          style: TextStyle(fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        child:
            //     caseStudyList.length == 0
            //         ? new Text('No Case Studies Uploaded')
            //         :
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                title == null ? "title" : title,
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    height: 2,
                                    color: Colors.deepPurple),
                              ),
                              Divider(),
                              Text(
                                'Description:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 21),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  description == null
                                      ? "description"
                                      : description,
                                  style: TextStyle(fontSize: 19),
                                  textAlign: TextAlign.left,
                                  maxLines: null,
                                ),
                              ),
                              Text(
                                'Case Study:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Text(
                                  body == null ? "body" : body,
                                  style: TextStyle(fontSize: 19),
                                  textAlign: TextAlign.left,
                                  maxLines: null,
                                ),
                              ),
                              Divider(),
                              Text(
                                'Questions:',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        question1 == null
                                            ? '1/ ' + "Q1"
                                            : '1/ ' + question1,
                                        style: TextStyle(fontSize: 19),
                                        textAlign: TextAlign.left,
                                        maxLines: null,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                controller: question1Controller,
                                validator: (v) =>
                                    v.isEmpty ? 'Enter Your Answer' : null,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Your Answer Here',
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        question2 == null
                                            ? '2/ ' + "Q2"
                                            : '2/ ' + question2,
                                        style: TextStyle(fontSize: 19),
                                        textAlign: TextAlign.left,
                                        maxLines: null,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                controller: question2Controller,
                                validator: (v) =>
                                    v.isEmpty ? 'Enter Your Answer' : null,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Your Answer Here',
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        question3 == null
                                            ? '3/ ' + "Q3"
                                            : '3/ ' + question3,
                                        style: TextStyle(fontSize: 19),
                                        textAlign: TextAlign.left,
                                        maxLines: null,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                controller: question3Controller,
                                validator: (v) =>
                                    v.isEmpty ? 'Enter Your Answer' : null,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Your Answer Here',
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        question4 == null
                                            ? '4/ ' + "Q4"
                                            : '4/ ' + question4,
                                        style: TextStyle(fontSize: 19),
                                        textAlign: TextAlign.left,
                                        maxLines: null,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                controller: question4Controller,
                                validator: (v) =>
                                    v.isEmpty ? 'Enter Your Answer' : null,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Your Answer Here',
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        question5 == null
                                            ? '5/ ' + "Q5"
                                            : '5/ ' + question5,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 19),
                                        maxLines: null,
                                      ),
                                    ],
                                  )),
                              TextFormField(
                                controller: question5Controller,
                                validator: (v) =>
                                    v.isEmpty ? 'Enter Your Answer' : null,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Write Your Answer Here',
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              width: 100,
                                              child: TextButton(
                                                onPressed: () {
                                                  var date = DateTime.now();
                                                  String formattedDate = DateFormat(
                                                          'dd/MM/yyyy - hh:mm a')
                                                      .format(date);
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    firebaseref
                                                        .child('case_study')
                                                        .child(widget.csKey)
                                                        .child('studID')
                                                        .child(getCurrentID())
                                                        .set({
                                                      "answer1":
                                                          question1Controller
                                                              .text,
                                                      "answer2":
                                                          question2Controller
                                                              .text,
                                                      "answer3":
                                                          question3Controller
                                                              .text,
                                                      "answer4":
                                                          question4Controller
                                                              .text,
                                                      "answer5":
                                                          question5Controller
                                                              .text,
                                                      "date": formattedDate,
                                                      "graded": "false",
                                                    });
                                                    ScaffoldMessenger.of(
                                                            this.context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Submitted Successfully'),
                                                        backgroundColor:
                                                            Colors.deepPurple,
                                                      ),
                                                    );
                                                    Navigator.pop(this.context);
                                                  }
                                                },
                                                child: Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))),
                              ),
                            ]),
                      )),
                )),
      ),
    );
  }

  getCaseStudyDetails() async {
    DataSnapshot snapshot = await _ref.child(widget.csKey).once();
    Map caseStudy = snapshot.value;
    title = caseStudy['title'];
    description = caseStudy['description'];
    body = caseStudy['body'];
    question1 = caseStudy['question1'];
    question2 = caseStudy['question2'];
    question3 = caseStudy['question3'];
    question4 = caseStudy['question4'];
    question5 = caseStudy['question5'];
  }
}
