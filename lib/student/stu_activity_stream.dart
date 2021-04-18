import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/functions/database.dart';
import 'studentNavBar.dart';

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
  String _id = getCurrentID(); //
  @override
  void initState() {
    super.initState();
    _courseTitle =
        firebaseref.child('course').orderByChild('studID/$_id').equalTo(_id); //
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
        query: _courseTitle,
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      height: 2,
                                      color: Colors.deepPurple),
                                ),
                                Text(
                                  'Instructor: ' + list['instID'],
                                ),
                                Text(
                                  'status', //temp
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          'Date', //temp
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
      ],
    );
  }
}
