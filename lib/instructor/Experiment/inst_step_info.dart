import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ExpStepDetail extends StatefulWidget {
  final String snapshotKey;
  final String expsnapkey;
  ExpStepDetail({this.snapshotKey, this.expsnapkey});

  @override
  _ExpStepDetailState createState() => _ExpStepDetailState();
}

class _ExpStepDetailState extends State<ExpStepDetail> {
  String expkey;
  Map stepInfo;
  //------------------------------------------------
  TextEditingController stepNumController,
      questionController,
      cFeedbackController,
      discrController,
      incFeedbackController,
      imageController,
      option1Controller,
      option2Controller,
      option3Controller,
      option4Controller,
      option5Controller;
  //------------------------------------------------
  Query dbRefChoice;
  DatabaseReference dbRef;
  //------------------------------------------------
  void initState() {
    super.initState();

    expkey = widget.expsnapkey;
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .child(expkey)
        .child('steps');

    stepNumController = TextEditingController();
    cFeedbackController = TextEditingController();
    discrController = TextEditingController();
    questionController = TextEditingController();
    incFeedbackController = TextEditingController();
    imageController = TextEditingController();
    option1Controller = TextEditingController();
    option2Controller = TextEditingController();
    option3Controller = TextEditingController();
    option4Controller = TextEditingController();
    option5Controller = TextEditingController();

    getDetail();
  }

  getDetail() async {
    DataSnapshot snapshot = await dbRef.child(widget.snapshotKey).once();
    stepInfo = snapshot.value;
    stepNumController.text = stepInfo['step_number'];
    cFeedbackController.text = stepInfo['correct_feedback'];
    discrController.text = stepInfo['description'];
    questionController.text = stepInfo['question'];
    incFeedbackController.text = stepInfo['incorrect_feedback'];
    imageController.text = stepInfo['image'];
    option1Controller.text = stepInfo['option1'];
    option2Controller.text = stepInfo['option2'];
    option3Controller.text = stepInfo['option3'];
    option4Controller.text = stepInfo['option4'];
    option5Controller.text = stepInfo['option5'];
  }

//---------------------------------BUILD----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Step Information"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Step Number:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 35,
                  child: TextFormField(
                    readOnly: true,
                    controller: stepNumController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0))),
                      hintText: 'num',
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: discrController,
              readOnly: true,
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
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              controller: questionController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Write the Question here',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Options:',
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
              readOnly: true,
              controller: option1Controller,
              decoration: InputDecoration(
                hintText: 'Option 1 (Correct Option)',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: option2Controller,
              decoration: InputDecoration(
                hintText: 'Option 2',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: option3Controller,
              decoration: InputDecoration(
                hintText: 'Option 3',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: option4Controller,
              decoration: InputDecoration(
                hintText: 'Option 4',
              ),
            ),
            TextFormField(
              readOnly: true,
              controller: option5Controller,
              decoration: InputDecoration(
                hintText: 'Option 5',
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
            TextFormField(
              readOnly: true,
              controller: cFeedbackController,
              decoration: InputDecoration(
                hintText: 'Correct Feedback',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              controller: incFeedbackController,
              decoration: InputDecoration(
                hintText: 'Incorrect Feedback',
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
