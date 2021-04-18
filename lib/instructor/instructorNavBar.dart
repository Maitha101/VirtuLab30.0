import 'package:flutter/material.dart';
import 'inst_report.dart';
import 'inst_experiments.dart';
import 'inst_case_studies.dart';
import 'inst_settings.dart';

class InstructorNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstructorNavBar();
  }
}

class _InstructorNavBar extends State<InstructorNavBar> {
  
  int _barIndex = 0; //underscore makes it a private variable
  List<Widget> _selectedBarItem = <Widget>[
    InstReport(), //0
    InstExperiments(), //1
    InstCaseStudies(), //2
    InstSettings(), //3
  ];

  void navBarState(int index) {
    //sets nav bar state
    setState(() {
      _barIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _selectedBarItem.elementAt(_barIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _barIndex, //property of BottomNavigationBar
        onTap: navBarState, //sets state
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: 'Report'), //0
          BottomNavigationBarItem(
              icon: Icon(Icons.biotech), label: 'Experiments'), //1
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Case Studies'), //2
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'), //3
        ],
      ),
    );
  }
}
