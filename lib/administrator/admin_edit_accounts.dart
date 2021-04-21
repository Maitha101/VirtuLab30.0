import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminEditAccounts extends StatefulWidget {
  final String courseKey;
  final String instID;
  final String courseName;

  AdminEditAccounts({this.courseKey, this.instID,this.courseName});

  @override
  _AdminEditAccountsState createState() => _AdminEditAccountsState();
}

class _AdminEditAccountsState extends State<AdminEditAccounts> {
  int length = 0;

  List studentKey = [];
  TextEditingController _instController;
  final _formKey = GlobalKey<FormState>();

  getStudentList() {
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

      print(studentKey.length);
      print(keys);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _instController = TextEditingController();
    _instController.text = widget.instID;
    getStudentList();
    setState(() {
      Timer(Duration(seconds: 1), () {
        setState(() {
          print("//");
        });
      });
      //
    });
  }

  @override
  Widget build(BuildContext context) {
    List students = [
      "Student 1",
      "Student 2",
      "Student 3",
      "Student 4",
      "Student 5",
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        onPressed: () {
          print(auth.currentUser.uid);
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Inst ID : " + widget.instID,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              updateInstDialog();
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.repeat,
                                color: Colors.white,
                              ),
                              CustomText(
                                text: "Change",
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
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
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .58,
                child: ListView.builder(
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
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: "Student : " + studentKey[index],
                                  fontSize: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 13),
                                  child: GestureDetector(
                                    onTap: () {
                                      print("aa");
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
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Container(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CustomText(text: "Edit Inst ID",
                  fontSize: 22,
                  fontWeight: FontWeight.w600,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 35, horizontal: 20),
                child: TextFormField(
                  style: TextStyle(fontSize: 19),
                  controller: _instController,
                  decoration: InputDecoration(
                      hintText: "Enter Instructor ID",
                      prefixIcon: Icon(Icons.edit)
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: CustomText(text: "Cancel",)),
                  SizedBox(width: 20,),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)

                    ),
                    child: TextButton(
                        onPressed: () {
                         updateInst();
                         Navigator.pop(context);
                         ScaffoldMessenger.of(this.context).showSnackBar(
                           SnackBar(
                             duration: Duration(seconds: 2),
                             content:
                             CustomText(text: 'Instructor Updated Successfully',
                             color: Colors.white,
                             fontSize: 20,),
                             backgroundColor:
                             Colors.deepPurple, //change?
                           ),
                         );
                        },
                        child: CustomText(
                          text: "Update", color: Colors.white,)),
                  ),
                ],
              )

            ],
          ),
        ),
      );
    });
  }

  updateInst() {
    String instID = _instController.text;
    Map<String, String> inst = {
      "instID": instID
    };
    firebaseref.child('course').child(widget.courseKey).update(inst).then((value) => {
      Navigator.pop(context)
    });
  }
}
