import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminEditCourse extends StatefulWidget {
  final String courseKey;
  AdminEditCourse({this.courseKey});

  @override
  _AdminEditCourseState createState() => _AdminEditCourseState();
}

class _AdminEditCourseState extends State<AdminEditCourse> {
  TextEditingController _nameController , _instIDController , _codeController ,
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
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _codeController,
                decoration: InputDecoration(
                    hintText:"Course Code",
                    contentPadding: EdgeInsets.all(15),
                    hintStyle: TextStyle(fontSize: 22),
                    prefixIcon: Icon(Icons.edit,size: 25,)
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _nameController,
                decoration: InputDecoration(
                    hintText:"Course Name",
                    prefixIcon: Icon(Icons.edit)
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _instIDController,
                decoration: InputDecoration(
                    hintText:"Instructor",
                    prefixIcon: Icon(Icons.edit)
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                style: TextStyle(fontSize: 19),
                controller: _descController,
                decoration: InputDecoration(
                    hintText:"Course Description",
                    prefixIcon: Icon(Icons.edit)
                ),
              ),
              SizedBox(height: 60,),

              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)
                ),
                height: 50,
                width: 200,
                child: TextButton(onPressed: (){
                  saveCourse();
                }, child: CustomText(
                  text: "Update Course",
                  fontSize: 25,
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
    _nameController.text   = course['name'];
    _codeController.text   =  course['code'];
    _descController.text   =  course['description'];
  }

  saveCourse(){
    String instID = _instIDController.text;
    String name   = _nameController.text;
    String code   = _codeController.text;
    String description = _descController.text;

    Map<String,String> course = {
      'instID' :instID,
      'name'  :name,
      'code'  :code,
      'description' : description
    };
    _ref.child(widget.courseKey).update(course).then((value) => {
      Navigator.pop(context)
    });
  }

}
