import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/student/stu_case_study_view.dart';
import 'stu_course_contents.dart';

class CaseStudiesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CaseStudiesList();
  }
}

class _CaseStudiesList extends State<CaseStudiesList> {
  Query _caseStudyTitle;

  @override
  void initState() {
    String cId_false = courseKey + "false";
    super.initState();
    // exception handel
    try {
      _caseStudyTitle = firebaseref
          .child('case_study')
          .orderByChild('cID_draft')
          .equalTo(cId_false);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Case Studies'),
        backgroundColor: Colors.deepPurple,
      ),
      body: FirebaseAnimatedList(
        query: _caseStudyTitle,
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, snapshot,
            Animation<double> animation, int index) {
          Map caseStudy = snapshot.value;
          caseStudy['key'] = snapshot.key;
          return _caseStudyList(caseStudy: caseStudy);
        },
      ),
    );
  }

  Widget _caseStudyList({Map caseStudy}) {
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
                        Icon(
                          Icons.description_sharp,
                        ),
                        SizedBox(width: 15),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                caseStudy['title'],
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
                                      builder: (context) => CaseStudyView(
                                        csKey: caseStudy['key'],
                                        caseStudyName: caseStudy['title'],
                                      ),
                                    ),
                                  )
                                },
                            child: Text('Start'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.amber))),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
