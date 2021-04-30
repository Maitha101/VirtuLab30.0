import 'package:flutter/material.dart';
import 'inst_case_study_info.dart';
import 'inst_cs_student_select.dart';

class SubmittedCsSelect extends StatefulWidget {
  final String snapshotKey;
  SubmittedCsSelect({this.snapshotKey});
  @override
  State<StatefulWidget> createState() {
    return _SubmittedCsSelect();
  }
}

class _SubmittedCsSelect extends State<SubmittedCsSelect> {
  

  TextStyle _txtStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600,);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Case Studies'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CaseStudyDetail(
                                snapshotKey: widget.snapshotKey)));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 35, 15, 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Case Study Details', style: _txtStyle),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CsStudentSelect(
                                snapshotKey: widget.snapshotKey)));
                  },
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 35, 15, 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Student Submissions',
                          style: _txtStyle,
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
