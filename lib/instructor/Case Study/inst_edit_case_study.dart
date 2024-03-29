import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:virtulab/instructor/inst_report.dart';

class CaseStudyEditForm extends StatefulWidget {
  final String snapshotKey;
  CaseStudyEditForm({this.snapshotKey});

  @override
  CaseStudyEditFormState createState() => CaseStudyEditFormState();
}

// this Widget takes cs_questions_dynamicTF.dart for duplicaton
class CaseStudyEditFormState extends State<CaseStudyEditForm> {
  TextStyle _fieldInfo = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple);

  DateTime _deadline = DateTime.now();
  bool dateCheckBoxValue = false;
  DatabaseReference dbRef;
  bool _loading = false;
  Map csInfo;
  final _formkey = GlobalKey<FormState>(); //for validation
  // --------------------------controllers--------------------------------------
  TextEditingController titleController,
      bodyController,
      discrController,
      gradeController,
      deadlineController,
      question1Controller,
      question2Controller,
      question3Controller,
      question4Controller,
      question5Controller;
  //-----------------------------Functions--------------------------------------
  // exception handel
  void initState() {
    super.initState();
    try {
      dbRef = FirebaseDatabase.instance
          .reference()
          .child("case_study")
          .child(widget.snapshotKey);
    } catch (e) {
      print(e.toString());
    }

    titleController = TextEditingController();
    bodyController = TextEditingController();
    discrController = TextEditingController();
    gradeController = TextEditingController();
    deadlineController = TextEditingController();
    question1Controller = TextEditingController();
    question2Controller = TextEditingController();
    question3Controller = TextEditingController();
    question4Controller = TextEditingController();
    question5Controller = TextEditingController();
    getDetail();
  }

  getDetail() async {
    DataSnapshot snapshot = await dbRef.once();
    csInfo = snapshot.value;
    titleController.text = csInfo['title'];
    gradeController.text = csInfo['total_grade'];
    discrController.text = csInfo['description'];
    bodyController.text = csInfo['body'];
    deadlineController.text = csInfo['deadline'];
    // imageController.text = csInfo['image'];
    question1Controller.text = csInfo['question1'];
    question2Controller.text = csInfo['question2'];
    question3Controller.text = csInfo['question3'];
    question4Controller.text = csInfo['question4'];
    question5Controller.text = csInfo['question5'];
  }

  updateData() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      await dbRef.update({
        "title": titleController.text,
        "description": discrController.text,
        "body": bodyController.text,
        "question1": question1Controller.text,
        "question2": question2Controller.text,
        "question3": question3Controller.text,
        "question4": question4Controller.text,
        "question5": question5Controller.text,
        "total_grade": gradeController.text,
        "deadline": deadlineController.text,
      });
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

// CASE STUDY FORM -- START --
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text('Edit Case Study'),
      ),
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
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
                      validator: (v) => v.isEmpty ? "Enter title" : null,
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
                      validator: (v) => v.isEmpty ? "enter description" : null,
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
                      validator: (v) => v.isEmpty ? "enter question" : null,
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
                    Text('Questions', style: _fieldInfo),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Question" : null,
                      controller: question1Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 1',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Question" : null,
                      controller: question2Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 2',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Question" : null,
                      controller: question3Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 3',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Question" : null,
                      controller: question4Controller,
                      decoration: InputDecoration(
                        hintText: 'Question 4',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Question" : null,
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
                      validator: (v) => v.isEmpty ? "Grade" : null,
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
                          validator: (v) => v.isEmpty ? "enter deadline" : null,
                          controller: deadlineController,
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                            hintText: 'Deadline: -DD/MM/YYY-',
                          ),
                        ),
                      ),
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                updateData();
                                dbRef.update({
                                  "draft": 'false',
                                  "cID_draft": courseKey + 'false',
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text(
                                        'Case Study Submitted Succesfully'),
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
                                updateData();
                                dbRef.update({
                                  "draft": 'true',
                                  "cID_draft": courseKey + 'true'
                                });
                                Navigator.pop(context);
                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content:
                                        Text('Case Study Updated Sucesfully'),
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
                          ),
                          SizedBox(width: 15),
                          ElevatedButton(
                            onLongPress: () {
                              dbRef
                                  .remove()
                                  .whenComplete(() => Navigator.pop(context));
                              ScaffoldMessenger.of(this.context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text('Case Study deleted Succesfully'),
                                  backgroundColor: Colors.deepPurple,
                                ),
                              );
                            },
                            onPressed: () {
                              ScaffoldMessenger.of(this.context).showSnackBar(
                                SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                      'Hold the Delete button to delete the case study'),
                                  backgroundColor: Colors.deepPurple,
                                ),
                              );
                            },
                            child: Text('Delete Draft'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red[700])),
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
