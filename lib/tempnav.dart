import 'package:flutter/material.dart';
import 'package:virtulab/administrator/adminNavBar.dart';

import 'student/stu_activity_stream.dart';
import 'instructor/inst_report.dart';
import 'instructor/inst_course_select.dart';

// ...........................THIS PAGE WILL BE DELETED LATER

const TextStyle _textStyle =
    TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

ButtonStyle _buttonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
);

class TempNaV extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TempNaV();
  }
}

class _TempNaV extends State<TempNaV> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'THIS IS ONLY TEMPORARY \n where do you want to go?',
          style: _textStyle,
        ),
        SizedBox(
          width: 250,
          height: 75,
          child: ElevatedButton(
            style: _buttonStyle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => MainStudent(),
                ),
              );
            },
            child: Text(
              'Student',
              style: _textStyle,
            ),
          ),
        ),
        SizedBox(
          width: 250,
          height: 75,
          child: ElevatedButton(
            style: _buttonStyle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => InstCourseSelect(),
                ),
              );
            },
            child: Text(
              'Instructor',
              style: _textStyle,
            ),
          ),
        ),
        SizedBox(
          width: 250,
          height: 75,
          child: ElevatedButton(
            style: _buttonStyle,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AdminNavBar()//MainAdmin(),
                ),
              );
            },
            child: Text(
              'Admin',
              style: _textStyle,
            ),
          ),
        ),
      ],
    );
  }
}
