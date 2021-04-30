import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'Experiment/inst_edit_steps_list.dart';
import 'Experiment/inst_step_list.dart';
import 'Experiment/inst_create_exp.dart';
import 'inst_report.dart'; // << --- import inst report to use global course key

class InstExperiments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstExperiments();
  }
}

class _InstExperiments extends State<InstExperiments> {
  Query dbRef;
  Query dbRefDraft;

  DataSnapshot snapshot;

  @override
  void initState() {
    String cId_true = courseKey +
        "true"; //<< -- get drafted experiments with specefic course key
    String cId_false = courseKey +
        "false"; //<< -- get submitted experiments with specefic course key
    super.initState();

    // exception handel
    try {
      dbRef = FirebaseDatabase.instance // <<-- get submitted experiments
          .reference()
          .child('experiment')
          .orderByChild('cID_draft')
          .equalTo(cId_false);
      debugPrint(cId_false);
    }
    catch (e) {
      print(e.toString());
    }

    try {
      dbRefDraft = FirebaseDatabase.instance // <<-- get drafted experiments
          .reference()
          .child('experiment')
          .orderByChild('cID_draft')
          .equalTo(cId_true);
    }

    catch (e) {
      print(e.toString());
    }
  }
//
  Widget _buildExperimentList({Map experiment}) {
    return InkWell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
          child: Card(
            elevation: 10,
            shadowColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        experiment['draft'] == 'false'
                            ? Icons.science_outlined
                            : Icons.drafts_outlined,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          experiment['title'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
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
          ),
        ),
        onTap: () {
          if (experiment['draft'] == 'true') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InstExperimentsStepList(
                        snapshotKey: experiment['key'])));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InstExperimentsStep(snapshotKey: experiment['key'])));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.yellow[700],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => CreateExperiment(),
              ),
            );
          },
          icon: Icon(Icons.add),
          label: Text('New'),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text('Experiments'),
          backgroundColor: Colors.deepPurple,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Submitted'),
              ),
              Tab(
                child: Text('Drafts'),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Tab(
            child: Container(
              child: FirebaseAnimatedList(
                  query: dbRef,
                  defaultChild: Center(child: CircularProgressIndicator()),
                  itemBuilder: (BuildContext context, snapshot,
                      Animation<double> animation, int index) {
                    Map experiment = snapshot.value;
                    experiment['key'] = snapshot.key;
                    return _buildExperimentList(experiment: experiment);
                  }),
            ),
          ),
          Tab(
            child: Container(
              child: FirebaseAnimatedList(
                  query: dbRefDraft,
                  defaultChild: Center(child: CircularProgressIndicator()),
                  itemBuilder: (BuildContext context, snapshot,
                      Animation<double> animation, int index) {
                    Map experiment = snapshot.value;
                    experiment['key'] = snapshot.key;
                    return _buildExperimentList(experiment: experiment);
                  }),
            ),
          ),
        ]),
      ),
    );
  }
}
