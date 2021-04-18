import 'package:flutter/material.dart';
import 'stu_activity_stream.dart';
import 'stu_courses.dart';
import 'stu_grades.dart';
import 'stu_settings.dart';


class StudentNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentNavBar();
  }
}

class _StudentNavBar extends State<StudentNavBar> {
  int _barIndex = 0; //underscore makes it a private variable
  
   List <Widget> _selectedBarItem =<Widget>[
    ActivityStream(), //0
    StudentCourses(), //1
    StudentGrades(), //2
    StudentSettings(), //3
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
      body: Center(child:_selectedBarItem.elementAt(_barIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _barIndex, //property of BottomNavigationBar
        onTap: navBarState, //sets state
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.view_stream), label: 'Stream'), //0
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'), //1
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'), //2
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'), //3
        ],
      ),

      // body: new IndexedStack(
      //   index: _barIndex,
      //   children:[
      //     new ActivityStream(), //0
      //     new StudentCourses(), //1
      //     new StudentGrades(), //2
      //     new StudentSettings(), //3
      //   ],
      // ),
    );
  }
}
