import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'inst_step_info.dart';

// THIS SCREEN LISTS SUBMITTED EXP STEPS FOR READING AND DELETION OF EXP !!!
class InstExperimentsStep extends StatefulWidget {
  final String snapshotKey;
  InstExperimentsStep({this.snapshotKey});
  @override
  State<StatefulWidget> createState() {
    return _InstExperimentsStep();
  }
}

class _InstExperimentsStep extends State<InstExperimentsStep> {
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

  Widget _buildExperimentList({Map experiment}) {
    return InkWell(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Step number: " + experiment['step_number'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ExpStepDetail(
                        snapshotKey: experiment['key'],
                        expsnapkey: key,
                      )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Experiment Steps'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onLongPress: () {
                    dbrefrence.remove().whenComplete(() => Navigator.of(context)
                        .popUntil((route) => route.isFirst));
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Experiment deleted Sucesfully'),
                        backgroundColor: Colors.deepPurple, 
                      ),
                    );
                  },
                  onPressed: () {
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                            'Hold the Delete button to delete the Experiment'),
                        backgroundColor: Colors.red[700], 
                      ),
                    );
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red[700])),
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
                    Map experiment = snapshot.value;
                    experiment['key'] = snapshot.key;
                    return _buildExperimentList(experiment: experiment);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
