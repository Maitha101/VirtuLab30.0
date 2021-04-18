import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/instructor/inst_experiments.dart';
import 'inst_step_edit.dart';
import 'inst_step_form.dart';
import 'package:virtulab/instructor/inst_report.dart';

// THIS SCREEN LISTS DRAFTED EXP STEPS FOR EDITING/ DELETION OF STEPS OR EXP!!!
class InstExperimentsStepList extends StatefulWidget {
  final String snapshotKey;
  InstExperimentsStepList({this.snapshotKey});
  @override
  State<StatefulWidget> createState() {
    return _InstExperimentsStepList();
  }
}

class _InstExperimentsStepList extends State<InstExperimentsStepList> {
  Query dbRef;
  DatabaseReference dbrefrence;
  DataSnapshot snapshot;
  String key;

  @override
  void initState() {
    super.initState();
    key = widget.snapshotKey;
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .child(key)
        .child('steps');
    dbrefrence =
        FirebaseDatabase.instance.reference().child('experiment').child(key);
  }

  Widget _buildExperimentList({Map step}) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ExpStepEditDetail(
                      snapshotKey: step['key'],
                      expsnapkey: key,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Step number: " + step['step_number'],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87),
            ),
            SizedBox(
              width: 100,
            ),
            GestureDetector(
              onTap: () {
                _showStepDeleteDialog(step: step);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.delete,
                    color: Colors.red[700],
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.red[700],
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Experiment'),
            content: Text('are you sure you want to delete the experiment?'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  dbrefrence.remove();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(this.context).showSnackBar(
                    SnackBar(
                      content: Text('Experiment deleted Sucesfully'),
                      backgroundColor: Colors.deepPurple, //change?
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: Text('Delete'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red[700])),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey)),
              )
            ],
          );
        });
  }

  _showStepDeleteDialog({Map step}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Experiment Step'),
            content:
                Text('are you sure you want to delete this experiment step?'),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    dbrefrence
                        .child('steps')
                        .child(step['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
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
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Experiment Steps'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    //SUBMIT BUTTON
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        dbrefrence.update({
                          "cID_draft": courseKey + 'false',
                          "draft": 'false',
                        });
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        ScaffoldMessenger.of(this.context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('Experiment Submitted Sucesfully'),
                            backgroundColor: Colors.deepPurple, //change?
                          ),
                        );
                      },
                      child: Text('Submit'),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                    ),
                  ),
                  SizedBox(
                    //DRAFT BUTTON
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        dbrefrence.update({
                          "cID_draft": courseKey + 'true',
                          "draft": 'true',
                        });
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        ScaffoldMessenger.of(this.context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 2),
                            content: Text('Experiment Saved Sucesfully'),
                            backgroundColor: Colors.deepPurple, //change?
                          ),
                        );
                      },
                      child: Text('Save Draft'),
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurple)),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  // ADD STEP BUTTON
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => ExperimentStepForm(
                            snapshotKey: key,
                          ),
                        ),
                      );
                    },
                    child: Text('Add Step'),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                  ),
                ),
                SizedBox(
                  //DELETE BUTTON
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onLongPress: () {
                      dbrefrence.remove().whenComplete(() =>
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst));
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Experiment deleted Sucesfully'),
                          backgroundColor: Colors.deepPurple, //change?
                        ),
                      );
                    },
                    onPressed: () {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          content: Text(
                              'Hold the Delete button to delete the Experiment'),
                          backgroundColor: Colors.red[700], //change?
                        ),
                      );
                    },
                    child: Text('Delete'),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red[700])),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Container(
                child: FirebaseAnimatedList(
                  query: dbRef,
                  defaultChild: Center(child: CircularProgressIndicator()),
                  itemBuilder: (BuildContext context, snapshot,
                      Animation<double> animation, int index) {
                    Map step = snapshot.value;
                    step['key'] = snapshot.key;
                    return _buildExperimentList(step: step);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
