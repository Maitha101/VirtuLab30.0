import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';
import 'package:virtulab/widgets/custom_text_from_field.dart';

class AdminAddCourse extends StatefulWidget {
  @override
  _AdminAddCourseState createState() => _AdminAddCourseState();
}

class _AdminAddCourseState extends State<AdminAddCourse> {
  List<String> instructorList = [
    "101010", "123456", "111222"
  ];

  String dropDownValue;
  String courseTitle;
  String description;
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: CustomText(
          text: "Create New Course",
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: CustomText(
                  text: "Course Code :",
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextFormField(
                hintText: "Course Code",
                onChange: (value) {
                  courseTitle = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomText(
                  text: "Name :",
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextFormField(
                hintText: "Name",
                onChange: (value) {
                  name = value;
                },
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomText(
                  text: "Assign Instructor :",
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                  child: DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down,size: 30,),
                    hint: CustomText(text: "Choose Instructor",),
                    items: instructorList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 24),
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
              ) ,
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: CustomText(
                  text: "Description :",
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextFormField(
                hintText: "Description",
                onChange: (value) {
                  description = value;
                },
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                    height: 55,
                    width: 160,
                    child: TextButton(
                        onPressed: () {
                          addNewCourse(courseTitle, dropDownValue,description,name);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                            CustomText(
                              text: "Add Course",
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ],
                        )),
                  ),
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
  addNewCourse( String title, String instructor,String description,String name){
    firebaseref.child('course').push().set(
        {
          'code' : title,
          'description' : description,
          'name' : name,
          'instID' : instructor
        }
    );
  }
}
