import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
//import 'package:virtulab/functions/Student/class_experiment_list.dart';
//import 'package:virtulab/functions/class_experiment.dart';
//import 'package:virtulab/functions/database.dart';
//import 'package:virtulab/student/stu_caseStudies_list.dart';
//import 'package:virtulab/student/stu_course_contents.dart';
import 'package:virtulab/student/stu_experiment_view.dart';
import 'stu_course_contents.dart';
// import './studentNavBar.dart';

class ExperimentsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExperimentsList();
  }
}

class _ExperimentsList extends State<ExperimentsList> {
  Query dbRef;

  @override
  void initState() {
    debugPrint(courseKey);
    String cId_false = courseKey + "false";
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('experiment')
        .orderByChild('cID_draft')
        .equalTo(cId_false);
    super.initState();
  }

  Widget _buildExperimentList({Map experiment}) {
    return Card(
      child: InkWell(
        onTap: () {}, // Navigate when tapped
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //Multiple texts in a widget
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.thermostat_rounded),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experiment['title'],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                height: 2,
                                color: Colors.deepPurple),
                          ),
                          Text('attempted: true ?'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(
              //   width: 90,
              // ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExperimentView(
                        expKey: experiment['key'],
                        expName: experiment['title'],
                      ),
                    ),
                  ),
                },
                child: Text('Start'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber)),
                // color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Experiments'),
        backgroundColor: Colors.deepPurple,
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                child: FirebaseAnimatedList(
                  query: dbRef,
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
        ),
      ),
    );
  }
}
