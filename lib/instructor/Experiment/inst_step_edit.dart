import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ExpStepEditDetail extends StatefulWidget {
  final String snapshotKey;
  final String expsnapkey;
  ExpStepEditDetail({this.snapshotKey, this.expsnapkey});

  @override
  _ExpStepEditDetailState createState() => _ExpStepEditDetailState();
}

class _ExpStepEditDetailState extends State<ExpStepEditDetail> {
  String expkey;
  String stpkey;
  final _formkey = GlobalKey<FormState>(); //for validation
  bool _loading = false;
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
  //Query dbRefChoice;
  DatabaseReference dbRef;
  //------------------------------------------------
  void initState() {
    super.initState();
    stpkey = widget.snapshotKey;
    expkey = widget.expsnapkey;
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .child(expkey)
        .child('steps')
        .child(stpkey);

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
    DataSnapshot snapshot = await dbRef.once();
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

  updateData() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      await dbRef.update({
        "step_number": stepNumController.text,
        "description": discrController.text,
        "question": questionController.text,
        "option1": option1Controller.text,
        "option2": option2Controller.text,
        "option3": option3Controller.text,
        "option4": option4Controller.text,
        "option5": option5Controller.text,
        "correct_feedback": cFeedbackController.text,
        "incorrect_feedback": incFeedbackController.text,
      });
    }
  }

//---------------------------------BUILD----------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text('Edit Experiment Step'),
      ),
      body: _loading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
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
                            validator: (v) => v.isEmpty ? "" : null,
                            controller: stepNumController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0))),
                              hintText: 'num',
                            ),
                          ),
                        ),
                      ],
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
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter question" : null,
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
                      validator: (v) => v.isEmpty ? "enter Option" : null,
                      controller: option1Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 1 (Correct Option)',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Option" : null,
                      controller: option2Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 2',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Option" : null,
                      controller: option3Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 3',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Option" : null,
                      controller: option4Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 4',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Option" : null,
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
                      validator: (v) => v.isEmpty ? "enter Option" : null,
                      controller: cFeedbackController,
                      decoration: InputDecoration(
                        hintText: 'Correct Feedback',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "enter Option" : null,
                      controller: incFeedbackController,
                      decoration: InputDecoration(
                        hintText: 'Incorrect Feedback',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState.validate()) {
                                updateData();
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Next'),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber)),
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
