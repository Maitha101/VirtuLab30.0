import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/Model/stu_esp_step_model.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_experiment_tile.dart';
import 'package:virtulab/student/stu_experiments_list.dart';

class ExperimentView extends StatefulWidget {
  final String expKey;
  final String expName;
  ExperimentView({this.expKey, this.expName});

  @override
  State<StatefulWidget> createState() {
    return _ExperimentView();
  }
}

int length;
_showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
      child: Text('Cancel'),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop());
  Widget submitButton = FlatButton(
    child: Text('Submit'),
    onPressed: () {
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (context) => ExperimentsList()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Alert'),
    content: Text('Are you sure you want to submit?'),
    actions: [
      cancelButton,
      submitButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _ExperimentView extends State<ExperimentView> {
  Query dbref;
  DataSnapshot snapshot;
  Map experData;
  String stepn;
  StepModel stepModel;
  //--------------------------------------------------------------------------
  @override
  void initState() {
    dbref = firebaseref.child('experiment').child(widget.expKey).child('steps');
    //getExperimentData();
    setState(() {});
    super.initState();
  }

  StepModel getStepModelData({Map expData}) {
    StepModel stepModel = new StepModel();
    stepModel.stepNumber = expData['step_number'].toString();
    stepModel.description = expData['description'].toString();
    stepModel.question = expData['question'].toString();
    stepModel.correctFeedback = expData['correct_feedback'].toString();
    stepModel.incorrectFeedback = expData['incorrect_feedback'].toString();
    stepModel.attempted = false;

    List<String> options = [
      expData['option1'].toString(),
      expData['option2'].toString(),
      expData['option3'].toString(),
      expData['option4'].toString(),
      expData['option5'].toString(),
    ];
    options.shuffle();
    stepModel.option1 = options[0];
    stepModel.option2 = options[1];
    stepModel.option3 = options[2];
    stepModel.option4 = options[3];
    stepModel.option5 = options[4];
    stepModel.correctOption = expData['option1'].toString();

    return stepModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(widget.expName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Flexible(
              child: FirebaseAnimatedList(
                query: dbref,
                itemBuilder: (BuildContext context, snapshot,
                    Animation<double> animation, int index) {
                  debugPrint(
                      snapshot == null ? "empty snap" : "not empty snap");
                  Map stepData = snapshot.value;
                  stepData['key'] = snapshot.key;
                  debugPrint(stepData == null ? "empty map" : "not emp ty map");
                  return ExperimentTile(
                    stepModel: getStepModelData(expData: stepData),
                    stepindex: index,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Finish',
                style: TextStyle(color: Colors.black87),
              ),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18))),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.amber)),
            ),
          ],
        ),
      ),
    );
  }
}

class ExperimentTile extends StatefulWidget {
  final StepModel stepModel;
  final int stepindex;
  ExperimentTile({this.stepModel, this.stepindex});
  @override
  _ExperimentTileState createState() => _ExperimentTileState();
}

class _ExperimentTileState extends State<ExperimentTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return 
    Padding(
      padding: EdgeInsets.all(10),
          child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:10),
            Text(
              "Step: " + widget.stepModel.stepNumber,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Description: ' + widget.stepModel.description,
              style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[600]),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                widget.stepModel.question,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.purple[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                // is question attempted ?
                if (!widget.stepModel.attempted) {
                  //no
                  //is ans correct?
                  if (widget.stepModel.option1 ==
                      widget.stepModel.correctOption) {
                    //correct
                    optionSelected = widget.stepModel.option1;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  } else {
                    //incorrect
                    optionSelected = widget.stepModel.option1;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  }
                }
              },
              child: 
              ExperimentOptionTile(
                correctAnswer: widget.stepModel.correctOption,
                optionName: widget.stepModel.option1,
                option: "a",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                // is question attempted ?
                if (!widget.stepModel.attempted) {
                  //no
                  //is ans correct?
                  if (widget.stepModel.option2 ==
                      widget.stepModel.correctOption) {
                    //correct
                    optionSelected = widget.stepModel.option2;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  } else {
                    //incorrect
                    optionSelected = widget.stepModel.option2;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  }
                }
              },
              child: ExperimentOptionTile(
                correctAnswer: widget.stepModel.correctOption,
                optionName: widget.stepModel.option2,
                option: "b",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                // is question attempted ?
                if (!widget.stepModel.attempted) {
                  //no
                  //is ans correct?
                  if (widget.stepModel.option3 ==
                      widget.stepModel.correctOption) {
                    //correct
                    optionSelected = widget.stepModel.option3;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  } else {
                    //incorrect
                    optionSelected = widget.stepModel.option3;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  }
                }
              },
              child: ExperimentOptionTile(
                correctAnswer: widget.stepModel.correctOption,
                optionName: widget.stepModel.option3,
                option: "c",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                // is question attempted ?
                if (!widget.stepModel.attempted) {
                  //no
                  //is ans correct?
                  if (widget.stepModel.option4 ==
                      widget.stepModel.correctOption) {
                    //correct
                    optionSelected = widget.stepModel.option4;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  } else {
                    //incorrect
                    optionSelected = widget.stepModel.option4;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  }
                }
              },
              child: ExperimentOptionTile(
                correctAnswer: widget.stepModel.correctOption,
                optionName: widget.stepModel.option4,
                option: "d",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            InkWell(
              onTap: () {
                // is question attempted ?
                if (!widget.stepModel.attempted) {
                  //no
                  //is ans correct?
                  if (widget.stepModel.option5 ==
                      widget.stepModel.correctOption) {
                    //correct
                    optionSelected = widget.stepModel.option5;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  } else {
                    //incorrect
                    optionSelected = widget.stepModel.option5;
                    widget.stepModel.attempted = true;
                    setState(() {});
                  }
                }
              },
              child: ExperimentOptionTile(
                correctAnswer: widget.stepModel.correctOption,
                optionName: widget.stepModel.option5,
                option: "e",
                optionSelected: optionSelected,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (widget.stepModel.attempted)
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: Text(
                  optionSelected == widget.stepModel.correctOption
                      ? widget.stepModel.correctFeedback
                      : widget.stepModel.incorrectFeedback,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            Divider(
              color: Colors.yellow[700],
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }
}
