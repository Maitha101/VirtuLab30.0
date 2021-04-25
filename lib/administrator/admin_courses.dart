import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/administrator/admin_add_course.dart';
import 'package:virtulab/administrator/admin_edit_courses.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminCourses();
  }
}

class _AdminCourses extends State<AdminCourses> {
  Query _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('course');
  // exception handel
  @override
  void initState() {
    super.initState();
   try{
     _ref = FirebaseDatabase.instance
         .reference()
         .child('course')
         .orderByChild('code');
   }
   catch(e){
     print(e.toString());
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdminAddCourse()));
        },
        backgroundColor: Colors.amber,
        label: Text(
          "Create New Course",
          style: TextStyle(color: Colors.white),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Manage Courses'),
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
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: CustomText(
                text: "Courses:",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .65,
              child: FirebaseAnimatedList(
                  query: _ref,
                  defaultChild: Center(child: CircularProgressIndicator()),
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    Map coursesAdmin = snapshot.value;
                    coursesAdmin['key'] = snapshot.key;
                    return _buildCourses(course: coursesAdmin);
                  }),
            )
          ],
        ),
      ),
    );
  }

  _buildCourses({Map course}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
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
                        fontSize: 18,
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
                          fontSize: 16,
                          text: 'ID: ' + course['instID'],
                          color: Colors.grey)
                    ],
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminEditCourse(
                                            courseKey: course['key'],
                                          )));
                            }),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              _showDeleteDialog(course: course);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showDeleteDialog({Map course}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete ${course['code']}'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    reference
                        .child(course['key'])
                        .remove()
                        .whenComplete(() => Navigator.pop(context));
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }
}