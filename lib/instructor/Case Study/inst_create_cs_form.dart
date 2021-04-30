import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/instructor/inst_report.dart';

class CaseStudyForm extends StatefulWidget {
  @override
  CaseStudyFormState createState() => CaseStudyFormState();
}

// this Widget takes cs_questions_dynamicTF.dart for duplicaton
class CaseStudyFormState extends State<CaseStudyForm> {
  TextStyle _fieldInfo = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple);

  DateTime _deadline = DateTime.now();
  bool dateCheckBoxValue = false;
  DatabaseReference dbRef;
  bool _loading = false;
  final _formkey = GlobalKey<FormState>(); //for validation
  // --------------------------controllers--------------------------------------
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final discrController = TextEditingController();
  final gradeController = TextEditingController();
  final deadlineController = TextEditingController();
  final question1Controller = TextEditingController();
  final question2Controller = TextEditingController();
  final question3Controller = TextEditingController();
  final question4Controller = TextEditingController();
  final question5Controller = TextEditingController();
  //-------
  // ----------------------Functions--------------------------------------

  // exception handel
  @override
  void initState() {
    super.initState();
    try {
      dbRef = FirebaseDatabase.instance.reference().child("case_study");
    } catch (e) {
      print(e.toString());
    }
  }

  _datePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _deadline, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _deadline)
      setState(() {
        _deadline = picked;
      });
  }

// ------------------------CASE STUDY FORM -- START ----------------------------
  Widget build(BuildContext context) {
    return _loading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Title',
                      style: _fieldInfo,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'Enter the Case Study title here',
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Description',
                      style: _fieldInfo,
                    ),
                    TextFormField(
                      controller: discrController,
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Write a short Description of the Step',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.yellow[700],
                      thickness: 3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Body',
                      style: _fieldInfo,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: bodyController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Write the Case study body here',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Questions',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: question1Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 1',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: question2Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 2',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: question3Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 3',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: question4Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 4',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: question5Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 5',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.yellow[700],
                      thickness: 3,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Grade',
                      style: _fieldInfo,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "* Required" : null,
                      controller: gradeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Grade out of:',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Deadline',
                      style: _fieldInfo,
                    ),
                    CheckboxListTile(
                      title: Text('No Deadline'),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: dateCheckBoxValue,
                      onChanged: (bool value) {
                        setState(() {
                          dateCheckBoxValue = value;
                        });
                      },
                    ),
                    if (!dateCheckBoxValue)
                      Container(
                        height: 40,
                        child: TextFormField(
                          validator: (v) => v.isEmpty ? "* Required" : null,
                          controller: deadlineController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'Deadline: -DD/MM/YYYY-',
                          ),
                        ),
                      ),
                    SizedBox(height: 25),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                deadlineController.text =
                                    _deadline.toIso8601String();
                                dbRef.push().set({
                                  "title": titleController.text,
                                  "description": discrController.text,
                                  "body": bodyController.text,
                                  "total_grade": gradeController.text,
                                  "deadline": deadlineController.text,
                                  "draft": 'false',
                                  "cID_draft": courseKey + 'false',
                                  "question1": question1Controller.text,
                                  "question2": question2Controller.text,
                                  "question3": question3Controller.text,
                                  "question4": question4Controller.text,
                                  "question5": question5Controller.text,
                                  "course_id": courseKey,
                                });
                                firebaseref
                                    .child('course')
                                    .child(courseKey)
                                    .child('caseStudies')
                                    .push()
                                    .set({"csName": titleController.text});

                                Navigator.pop(context);
                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content:
                                        Text('Case Study submitted Sucesfully'),
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                );
                              }
                            },
                            child: Text('Submit'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepPurple)),
                          ),
                          SizedBox(width: 15),
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                dbRef.push().set({
                                  "title": titleController.text,
                                  "description": discrController.text,
                                  "body": bodyController.text,
                                  "total_grade": gradeController.text,
                                  "deadline": deadlineController.text,
                                  "draft": 'true',
                                  "cID_draft": courseKey + 'true',
                                  "question1": question1Controller.text,
                                  "question2": question2Controller.text,
                                  "question3": question3Controller.text,
                                  "question4": question4Controller.text,
                                  "question5": question5Controller.text,
                                  "course_id": courseKey,
                                });

                                Navigator.pop(context);
                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content:
                                        Text('Case Study saved Sucesfully'),
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                );
                              }
                            },
                            child: Text('Save Draft'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepPurple)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
