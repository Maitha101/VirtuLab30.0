import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/administrator/admin_edit_accounts.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminAccounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminAccounts();
  }
}

class _AdminAccounts extends State<AdminAccounts> {
  List courseName = [
    "Data Mining",
    "Data Structure",
    "Python",
    "Java",
    "C++",
  ];

  List instructorName = [
    "Mr Ahmed",
    "Mr Mohamed",
    "Mr Amr",
    "Mr Mahmoud",
    "Mr Abdallah"
  ];

  Query _courses;
  String _name;
  String _code;
  String _instID;
  String _description;
  int _studCount = 0;

  void initState() {
    _courses = firebaseref.child('course').orderByChild('code');
    // courseDetails();
    // studCount(null);
  }

  courseDetails() async {
    DataSnapshot snapshot = await _courses.once();
    Map course = snapshot.value;
    course['key'] = snapshot.key;
    _name = course['name'];
    _code = course['code'];
    _instID = course['instID'];

    DataSnapshot snap = await _courses.reference().child('studID').once();
    Map stud = snap.value;
    _studCount = stud.length;
    // debugPrint(' student count is $_studCount');
  }

  studCount(String key) async {
    DataSnapshot snap =
        await _courses.reference().child(key).child('studID').once();
    Map stud = snap.value;
    setState(() {
      _studCount = stud.length;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manage Accounts'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              child: CustomText(
                text: "Search:",
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "type here!",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Container(
                color: Colors.grey,
                height: 2,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 8),
              child: CustomText(
                text: "Courses:",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .50,
              child: FirebaseAnimatedList(
                query: _courses,
                defaultChild: Center(child: CircularProgressIndicator()),
                itemBuilder: (BuildContext context, snapshot,
                    Animation<double> animation, int index) {
                  Map _courseInfo = snapshot.value;
                  _courseInfo['key'] = snapshot.key;
                  return _courseList(course: _courseInfo);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _courseList({Map course}) {
    studCount(course['key']);
    return Container(
      // height: MediaQuery.of(context).size.height * .54,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: course['name'],
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text: 'Instructor: '+ course['instID'],
                      ),
                      CustomText(
                        text: "No. Students: $_studCount",
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: 33,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminEditAccounts(
                                      courseKey: course['key'],
                                      instID: course['instID'],
                                    )));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
