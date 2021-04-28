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
  List myCourse = [];

  Query _courses;

 // exception handel
  void initState() {
    super.initState();
    try{
      _courses = firebaseref.child('course').orderByChild('code');
    }catch(e){
      print(e.toString());
    }
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
            SizedBox(
              height: 25,
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
              height: MediaQuery.of(context).size.height * .73,
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
    // studCount(course['key']);
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdminEditAccounts(
                  courseName: course['name'],
                  courseKey: course['key'],
                  instID: course['instID'],
                  instName: course['instname'],
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
        child: Card(
          elevation: 10,
          shadowColor: Colors.deepPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            // height: MediaQuery.of(context).size.height * .54,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: course['name'],
                              fontSize: 19,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: CustomText(
                                fontSize: 16,
                                text: course['instname'],
                              ),
                            ),
                            CustomText(
                              text: "ID: " + course['instID'],
                              fontSize: 16,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 30,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () {

                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
