import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminEditCourse extends StatefulWidget {
  final String courseKey;
  AdminEditCourse({this.courseKey});

  @override
  _AdminEditCourseState createState() => _AdminEditCourseState();
}

class _AdminEditCourseState extends State<AdminEditCourse> {
  List<String> instructorList = [];
  String dropDownValue;
  TextEditingController _nameController,
      _instIDController,
      _codeController,
      _descController;
  DatabaseReference _ref;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _codeController = TextEditingController();
    _descController = TextEditingController();
    _instIDController = TextEditingController();
    _ref = FirebaseDatabase.instance.reference().child('course');
    getCourseDetails();
    getinstructor();
  }

  void getinstructor() async {
    firebaseref
        .child('instructor')
        .orderByChild('fname')
        .once()
        .then((DataSnapshot snapshot) {
      Map map = snapshot.value;
      setState(() {
        map.forEach((key, value) {
          instructorList
              .add(value['fname'] + " " + value['lname'] + " " + value['ID']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: CustomText(
          text: "Update Course",
          color: Colors.white,
          fontSize: 22,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _codeController,
                decoration: InputDecoration(
                    hintText: "Course Code",
                    contentPadding: EdgeInsets.all(15),
                    hintStyle: TextStyle(fontSize: 22),
                    prefixIcon: Icon(
                      Icons.edit,
                      size: 25,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Course Name", prefixIcon: Icon(Icons.edit)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: DropdownButton(
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                    ),
                    hint: CustomText(
                      text: "Choose Instructor",
                    ),
                    items: instructorList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }).toList(),
                    value: dropDownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                        return dropDownValue;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _descController,
                decoration: InputDecoration(
                    hintText: "Course Description",
                    prefixIcon: Icon(Icons.edit)),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                height: 50,
                width: 200,
                child: TextButton(
                    onPressed: () {
                      saveCourse(dropDownValue);
                    },
                    child: CustomText(
                      text: "Update Course",
                      fontSize: 20,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  getCourseDetails() async {
    DataSnapshot snapshot = await _ref.child(widget.courseKey).once();
    Map course = snapshot.value;
    _instIDController.text = course['instID'];
    _nameController.text = course['name'];
    _codeController.text = course['code'];
    _descController.text = course['description'];
  }

  saveCourse(String instructor) {
    var inst = instructor.split(" ");
    String instfname = inst[0];
    String instlname = inst[1];
    String instID = inst[2];
    String instname = instfname + " " + instlname;
    String name = _nameController.text;
    String code = _codeController.text;
    String description = _descController.text;

    Map<String, String> course = {
      'instID': instID,
      'instname': instname,
      'name': name,
      'code': code,
      'description': description
    };
    _ref
        .child(widget.courseKey)
        .update(course)
        .then((value) => {Navigator.pop(context)});
  }
}
