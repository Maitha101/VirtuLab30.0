import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';
import 'studentNavBar.dart';

//activity
class MainStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StudentNavBar();
    return MaterialApp(title: 'Student', home: StudentNavBar());
  }
}

class ActivityStream extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ActivityStream();
  }
}

class _ActivityStream extends State<ActivityStream> {
  Query _courseTitle;
  String _id = getCurrentID();
  @override
  void initState() {
    super.initState();
    // _courseTitle =
    //     firebaseref.child('course').orderByChild('studID/$_id').equalTo(_id); //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Activity Stream'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FirebaseAnimatedList(

        query: firebaseref.child('course').orderByChild('studID/$_id').equalTo(_id),
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index) {
          Map _courses = snapshot.value;
          _courses['key'] = snapshot.key;
          return _streamList(list: _courses);
        },
      ),
    );
  }

  Widget _streamList({Map list}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 10,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.campaign_sharp,
                              ),
                              SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list['name'],
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        height: 2,
                                        color: Colors.deepPurple),
                                  ),
                                  Text(
                                    'Instructor: ' + list['instname'],
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    child: CustomText(
                                      text: "CaseStudies",
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                 Container(
                                   height: 50,
                                   width: MediaQuery.of(context).size.width * .7,
                                   child: FirebaseAnimatedList(
                                     reverse: true,
                                       query: firebaseref.child('course').child(list['key']).child('caseStudies').orderByChild('csName'),
                                       itemBuilder: (BuildContext context, snapshot,
                                       Animation<double> animation, int index){
                                         Map caseStudy = snapshot.value;
                                         caseStudy['key'] = snapshot.key;
                                         return caseStudyList(caseStudy: caseStudy,index: index);
                                       }),
                                 ),
                                 SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 3),
                                    child: CustomText(
                                      text: "Experiments",
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19,
                                    ),
                                  ),
                                 Container(
                                   height: 50,
                                   width: MediaQuery.of(context).size.width * .7,
                                   child: FirebaseAnimatedList(
                                     reverse: true,
                                       query: firebaseref.child('course').child(list['key']).child('experiments').orderByChild('expName'),
                                       itemBuilder: (BuildContext context, snapshot,
                                       Animation<double> animation, int index){
                                         Map caseStudy = snapshot.value;
                                         caseStudy['key'] = snapshot.key;
                                         return experimentList(experiment: caseStudy,);
                                       }),
                                 ),

                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  caseStudyList({Map caseStudy , int index}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: CustomText(
            text: caseStudy['csName'] + " Added Successfully",
            // color: index == 0 ? Colors.deepOrange : Colors.green,
          ),
        )
      ],
    );
  }
  experimentList({Map experiment}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: experiment['expName'],
        )

      ],
    );
  }
}

