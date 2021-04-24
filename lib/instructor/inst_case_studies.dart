import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'Case Study/inst_case_study_info.dart';
import 'Case Study/inst_edit_case_study.dart';
import 'Case Study/inst_create_cs.dart';
import 'Case Study/inst_submitted_cs_select.dart';
import 'inst_report.dart';

//CHECK ECPERIMENTS FOR COURSE KEY DETAILS
class InstCaseStudies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstCaseStudies();
  }
}

class _InstCaseStudies extends State<InstCaseStudies> {
  Query dbRef;
  Query dbRefDraft;
  DataSnapshot snapshot;

  @override
  void initState() {
    String cId_true = courseKey + "true";
    String cId_false = courseKey + "false";
    super.initState();
    dbRef = FirebaseDatabase.instance
        .reference()
        .child('case_study')
        .orderByChild('cID_draft')
        .equalTo(cId_false);
    dbRefDraft = FirebaseDatabase.instance
        .reference()
        .child('case_study')
        .orderByChild('cID_draft')
        .equalTo(cId_true);
  }

  Widget _buildCaseStudyList({Map caseStudy}) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
          // height: 90,
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
                  Icon(
                    caseStudy['draft'] == 'false'
                        ? Icons.book_outlined
                        : Icons.drafts_outlined,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      caseStudy['title'],
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
        onTap: () {
          if (caseStudy['draft'] == 'true') {
            //draft
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CaseStudyEditForm(snapshotKey: caseStudy['key'])));
          } else {
            //submitted
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SubmittedCsSelect(snapshotKey: caseStudy['key'])));
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
                  builder: (BuildContext context) => CreateCaseStudy(),
                ),
              );
            },
            icon: Icon(Icons.add),
            label: Text('New'),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text('Case Studies'),
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
                      Map casestudy = snapshot.value;
                      casestudy['key'] = snapshot.key;
                      return _buildCaseStudyList(caseStudy: casestudy);
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
                      Map casestudy = snapshot.value;
                      casestudy['key'] = snapshot.key;
                      return _buildCaseStudyList(caseStudy: casestudy);
                    }),
              ),
            ),
          ])),
    );
  }
}
