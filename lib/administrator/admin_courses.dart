import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/administrator/admin_add_course.dart';
import 'package:virtulab/administrator/admin_edit_courses.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminCourses();
  }
}

class _AdminCourses extends State<AdminCourses> {
  Query _ref;
  int _studCount = 0;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('course');

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('course')
        .orderByChild('code');
        // studCount(null);
  }

  studCount(String key) async {
    DataSnapshot snap =
        await _ref.reference().child(key).child('studID').once();
    Map stud = snap.value;
    setState(() {
      _studCount = stud.length;
    });
    
  }

// Map myData ;
  // List getAllCourses = [];
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
          "Add New Course",
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
              padding: const EdgeInsets.only(left: 30, bottom: 10),
              child: CustomText(
                text: "Courses:",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .42,
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
    studCount(course['key']);
    return Padding(
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
                      text: "No.Student : $_studCount",
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 33,
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
                        size: 33,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _showDeleteDialog(course: course);
                      },
                    ),
                  ),
                ],
              )
            ],
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

// getCourses() async {
//   final courses = await firebaseref
//       .reference()
//       .child("course")
//       .once()
//       .then((DataSnapshot data) {
//     Map<dynamic, dynamic> courseValue1 = data.value;
//     // courseValue1['key'] = data.key;
//     courseValue1.forEach((key, value) {
//       getAllCourses.add({
//         'key' : courseValue1.keys,
//         'code': courseValue1[key]['code'],
//         'description': courseValue1[key]['description'],
//         'name': courseValue1[key]['name'],
//         'instID': courseValue1[key]['instID']
//       });
//           print(courseValue1.keys);
//     });
//   });
//
//   return getAllCourses;
// }

// deleteCourse() async {
//
//  await firebaseref.reference().child("course").child('key').remove();
// }

//   _buildCourseItems(){
//     return ListView.builder(
//         itemCount: getAllCourses.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(10)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(
//                         left: 20, top: 5, bottom: 5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CustomText(
//                           text: getAllCourses[index]['name'],
//                           fontSize: 21,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         CustomText(
//                           text: getAllCourses[index]['instID'],
//                         ),
//                         CustomText(
//                           text: "No.Student : 32",
//                           color: Colors.grey,
//                         )
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                           icon: Icon(
//                             Icons.edit,
//                             size: 33,
//                             color: Colors.blue,
//                           ),
//                           onPressed: () {}),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           right: 20,
//                         ),
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.delete,
//                             size: 33,
//                             color: Colors.red,
//                           ),
//                           onPressed: () {
//                             deleteCourse();
//                           },
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }

// class Courses {
//   String name;
//   String instID;
//   String code;
//   String description;
//
//   Courses({this.name, this.description, this.code, this.instID});
//
//   Courses.fromJson(DataSnapshot json) {
//     code = json.value['code'];
//     description = json.value['description'];
//     instID = json.value['instID'];
//     name = json.value['name'];
//   }
// }
