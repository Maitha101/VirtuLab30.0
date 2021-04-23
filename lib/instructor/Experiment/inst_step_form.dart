import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inst_edit_steps_list.dart';

class ExperimentStepForm extends StatefulWidget {
  final String snapshotKey;
  ExperimentStepForm({this.snapshotKey});
  @override
  ExperimentStepFormState createState() => ExperimentStepFormState();
}

class ExperimentStepFormState extends State<ExperimentStepForm> {
  final _formkey = GlobalKey<FormState>(); //for validation
  String key; //experiment key
  DatabaseReference dbRef;
  bool _loading = false;

//-------------------------------controllers----------------------------------
  final stepNumController = TextEditingController();
  final questionController = TextEditingController();
  final cFeedbackController = TextEditingController();
  final discrController = TextEditingController();
  final incFeedbackController = TextEditingController();
  final imageController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();
  final option5Controller = TextEditingController();

  //------------------------------FUNCTION--------------------------------------
  @override
  void initState() {
    key = widget.snapshotKey;
    super.initState();
    dbRef = FirebaseDatabase.instance
        .reference()
        .child("experiment")
        .child(key)
        .child('steps');
  }

  uploadData() async {
    if (_formkey.currentState.validate()) {
      setState(() {
        _loading = true;
      });
      await dbRef.push().set({
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
      }).catchError((e) {
        print(e);
      }).then((value) {
        setState(() {
          _loading = false;
        });
      });
    }
  }

// EXP STEP FORM -- START --
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text('Create Experiment Step'),
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
                          width: 60,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            validator: (v) => v.isEmpty ? "*Required" : null,
                            controller: stepNumController,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: discrController,
                      validator: (v) => v.isEmpty ? "*Required" : null,
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
                      validator: (v) => v.isEmpty ? "*Required" : null,
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
                      validator: (v) => v.isEmpty ? "*Required" : null,
                      controller: option1Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 1 (Correct Option)',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "*Required" : null,
                      controller: option2Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 2',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "*Required" : null,
                      controller: option3Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 3',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "*Required" : null,
                      controller: option4Controller,
                      decoration: InputDecoration(
                        hintText: 'Option 4',
                      ),
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "*Required" : null,
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
                      validator: (v) => v.isEmpty ? "*Required" : null,
                      controller: cFeedbackController,
                      decoration: InputDecoration(
                        hintText: 'Correct Feedback',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (v) => v.isEmpty ? "*Required" : null,
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
                                uploadData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InstExperimentsStepList(
                                      snapshotKey: key,
                                    ),
                                  ),
                                );
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
