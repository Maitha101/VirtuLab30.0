import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/administrator/admin_accounts.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminEditAccounts extends StatefulWidget {
  final String courseKey;
  final String instID;
  final String courseName;
  final String instName;

  AdminEditAccounts(
      {this.courseKey, this.instID, this.courseName, this.instName});

  @override
  _AdminEditAccountsState createState() => _AdminEditAccountsState();
}

class _AdminEditAccountsState extends State<AdminEditAccounts> {
  int length = 0;

  List studentKey = [];
  List allStudents = [];
  List studentNameList = [];
  TextEditingController _instController;
  final _formKey = GlobalKey<FormState>();

  // exception handel
  getStudentList() {
   try{
     DatabaseReference _data = firebaseref
         .reference()
         .child('course')
         .child(widget.courseKey)
         .child('studID');
     _data.once().then((DataSnapshot snapshot) {
       var keys = snapshot.value.keys;
       setState(() {
         studentKey.addAll(keys);
       });
     });
   } catch(e){
     e.toString();
   }
    getStudentDetails();
  }

  getStudentDetails() {
    String studentName;
    Map student;
    print(studentKey.length);
    for (int x = 0; x < studentKey.length; x++) {
      DatabaseReference _data =
          firebaseref.child("student").child(studentKey[x]);
      _data.once().then((DataSnapshot snapshot) => {
            student = snapshot.value,
            studentName = student['fname'] + " " + student['lname'],
            setState(() {
              studentNameList.add(studentName);
            }),
          });
    }
    print(studentNameList.length);

    return studentName;
  }

  // exception handel
  void getAllStudents() async {
    try{
      firebaseref
          .child('student')
          .orderByChild('fname')
          .once()
          .then((DataSnapshot snapshot) {
        Map map = snapshot.value;
        setState(() {
          map.forEach((key, value) {
            allStudents.add(value['ID']);
          });
        });
      });
    } catch(e){
      e.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _instController = TextEditingController();
    _instController.text = widget.instID;
    getStudentList();
    getAllStudents();
    setState(() {
      Timer(Duration(seconds: 1), () {
        setState(() {
          print("//");
        });
      });
      //
    });
    getStudentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {
          allStudentsDialog();
        },
        backgroundColor: Colors.amber,
        label: CustomText(
          text: "Add Student",
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: CustomText(
          text: widget.courseName,
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Instructor:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.instName,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: "ID: " + widget.instID,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: Container(
                color: Colors.grey,
                height: 2,
                width: double.infinity,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Students:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Container(
                height: MediaQuery.of(context).size.height * .58,
                child: studentKey.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/empty_placeholder.png"),
                          CustomText(
                            text: " No Student Registered In This Course!",
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount: studentKey.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 70,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: studentKey[index],
                                      fontSize: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 13),
                                      child: GestureDetector(
                                        onTap: () {
                                          _showDeleteDialog(index);
                                        },
                                        child: Column(
                                          children: [
                                            Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            CustomText(
                                              text: "Remove",
                                              color: Colors.red,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }

  updateInstDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 300,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: CustomText(
                        text: "Edit Inst ID",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 35, horizontal: 20),
                      child: TextFormField(
                        style: TextStyle(fontSize: 19),
                        controller: _instController,
                        validator: (v) =>
                            v.length != 6 ? "Invalid Instructor ID" : null,
                        decoration: InputDecoration(
                            hintText: "Enter Instructor ID",
                            prefixIcon: Icon(Icons.edit)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              text: "Cancel",
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  updateInst();
                                  Navigator.pop(context);
                                }

                                ScaffoldMessenger.of(this.context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: CustomText(
                                      text: 'Instructor Updated Successfully',
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    backgroundColor:
                                        Colors.deepPurple, //change?
                                  ),
                                );
                              },
                              child: CustomText(
                                text: "Update",
                                color: Colors.white,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  _showDeleteDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Student'),
            content: Text('Are you sure you want to delete?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    firebaseref
                        .child("course")
                        .child(widget.courseKey)
                        .child('studID')
                        .child(studentKey[index])
                        .remove()
                        .then((value) => {Navigator.pop(context)});
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        content: CustomText(
                          text: 'Student Deleted Successfully',
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        backgroundColor: Colors.deepPurple, //change?
                      ),
                    );
                  },
                  child: Text('Delete'))
            ],
          );
        });
  }

  updateInst() {
    String instID = _instController.text;
    Map<String, String> inst = {"instID": instID};
    firebaseref
        .child('course')
        .child(widget.courseKey)
        .update(inst)
        .then((value) => {Navigator.pop(context)});
  }

  allStudentsDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomText(
                      text: "Students List",
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .4,
                    child: ListView.builder(
                        itemCount: allStudents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                _showAddStudentDialog(index);
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)),
                                child: CustomText(
                                  text: "Student ${index + 1} : " +
                                      allStudents[index],
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: CustomText(
                          text: "Cancel",
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          );
        });
  }

  _showAddStudentDialog(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Student'),
            content: Text('Are you sure you want to Add ?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    firebaseref
                        .child('course')
                        .child(widget.courseKey)
                        .child('studID')
                        .child(allStudents[index])
                        .set(allStudents[index])
                        .then((value) => {Navigator.pop(context)});
                  },
                  child: Text('Add'))
            ],
          );
        });
  }
}
