import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/student/stu_experiment_view.dart';
import 'stu_course_contents.dart';

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
    // exception hanel
    try {
      dbRef = FirebaseDatabase.instance
          .reference()
          .child('experiment')
          .orderByChild('cID_draft')
          .equalTo(cId_false);
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  Widget _buildExperimentList({Map experiment}) {
    return Column(
      children: [
        Card(
          child: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.thermostat_rounded),
                        SizedBox(width: 15),
                        Flexible(
                          child: Column(
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
                            ],
                          ),
                        ),
                        SizedBox(width: 15),
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
