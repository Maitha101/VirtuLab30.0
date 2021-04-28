import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CaseStudyDetail extends StatefulWidget {
  final String snapshotKey;
  CaseStudyDetail({this.snapshotKey});

  @override
  _CaseStudyDetailState createState() => _CaseStudyDetailState();
}

class _CaseStudyDetailState extends State<CaseStudyDetail> {
  var title;
  var count = 0;
  TextStyle _fieldInfo = TextStyle(
      fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple);
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
  DatabaseReference dbRef;

  // exception handel
  void initState() {
    super.initState();
    try {
      dbRef = FirebaseDatabase.instance
          .reference()
          .child('case_study')
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
    Map caseStudyinfo = snapshot.value;
    title = caseStudyinfo['title'].toString();
    titleController.text = caseStudyinfo['title'];
    bodyController.text = caseStudyinfo['body'];
    discrController.text = caseStudyinfo['description'];
    gradeController.text = caseStudyinfo['total_grade'];
    deadlineController.text = caseStudyinfo['deadline'];
    question1Controller.text = caseStudyinfo['question1'];
    question2Controller.text = caseStudyinfo['question2'];
    question3Controller.text = caseStudyinfo['question3'];
    question4Controller.text = caseStudyinfo['question4'];
    question5Controller.text = caseStudyinfo['question5'];
  }

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Case Study'),
            content: Text('are you sure you want to delete the Case Study?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    dbRef.remove().whenComplete(() => Navigator.pop(context));
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text('Experiment deleted Sucesfully'),
                        backgroundColor: Colors.deepPurple, //change?
                      ),
                    );
                  },
                  child: Text('Delete')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          title: Text(' Case Study Information'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ListView(
            children: [
              Text(
                'Title',
                style: _fieldInfo,
              ),
              TextFormField(
                readOnly: true,
                controller: titleController,
              ),
              SizedBox(height: 30),
              Text(
                'Description',
                style: _fieldInfo,
              ),
              TextFormField(
                readOnly: true,
                controller: discrController,
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
                readOnly: true,
                controller: bodyController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Write the Question here',
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
                readOnly: true,
                controller: question1Controller,
                decoration: InputDecoration(
                  hintText: 'Question 1',
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: question2Controller,
                decoration: InputDecoration(
                  hintText: 'Question 2',
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: question3Controller,
                decoration: InputDecoration(
                  hintText: 'Question 3',
                ),
              ),
              TextFormField(
                readOnly: true,
                controller: question4Controller,
                decoration: InputDecoration(
                  hintText: 'Question 4',
                ),
              ),
              TextFormField(
                readOnly: true,
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
                readOnly: true,
                controller: gradeController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Deadline',
                style: _fieldInfo,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  readOnly: true,
                  controller: deadlineController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(hintText: 'No deadline set'),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onLongPress: () {
                  dbRef.remove().whenComplete(() =>
                      Navigator.of(context).popUntil((route) => route.isFirst));
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      content: Text('Case Study deleted Sucesfully'),
                      backgroundColor: Colors.deepPurple, //change?
                    ),
                  );
                },
                onPressed: () {
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                          'Hold the Delete button to delete the case study'),
                      backgroundColor: Colors.deepPurple, //change?
                    ),
                  );
                },
                child: Text('Delete'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red[700])),
              )
            ],
          ),
        ));
  }
}
