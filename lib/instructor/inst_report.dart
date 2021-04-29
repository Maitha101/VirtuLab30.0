import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator_nullsafe/circle/circular_percent_indicator.dart';
import 'package:percent_indicator_nullsafe/linear/linear_percent_indicator.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_placeholder.dart';
import 'package:virtulab/widgets/custom_text.dart';
import 'instructorNavBar.dart';

String
    courseKey; // << -- glabal key that has course key ((taken from course select))

class MainInstructor extends StatelessWidget {
  final String
      cKey; // <<--- initialize ckey to recieve course key from course select
  MainInstructor({this.cKey});

  @override
  Widget build(BuildContext context) {
    courseKey = cKey; //<< -- global coursekey == cKey
    // StudentNavBar();
    return MaterialApp(title: 'Instructor', home: InstructorNavBar());
  }
}

class InstReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstReport();
  }
}

class _InstReport extends State<InstReport> {
  Query _query ;
  bool check = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _query = firebaseref
        .child('case_study')
        .orderByChild('course_id')
        .equalTo(courseKey);
    // _query.once().then((DataSnapshot snapshot) => {
    //   if(snapshot.value == null){
    //     check = false
    //   }else{
    //     check = true
    //   }
    // });
    // setState(() {
    //   Timer(Duration(seconds: 1), () {
    //     setState(() {
    //       print(check);
    //     });
    //   });
    //   //
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Report Summary'),
          backgroundColor: Colors.deepPurple,
        ),
        body:Container(
          child: FirebaseAnimatedList(
              query: firebaseref
                  .child('case_study')
                  .orderByChild('course_id')
                  .equalTo(courseKey),
              itemBuilder: (BuildContext context, snapshot,
                  Animation<double> animation, int index) {
                Map caseStudy1 = snapshot.value;
                caseStudy1['key'] = snapshot.key;
                return caseStudyInfo(caseStudy: caseStudy1);
              }),
        ));
  }

  caseStudyInfo({Map caseStudy}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 8),
      child: Card(
        elevation: 10,
        shadowColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: caseStudy['title'],
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
                SizedBox(height: 5,),
                Container(
                  height: 170,
                  child: FirebaseAnimatedList(
                    query: firebaseref.child('case_study').child(caseStudy['key']).child('studID').orderByChild('answer1'),
                    itemBuilder: (BuildContext context, snapshot,
                    Animation<double> animation, int index){
                      Map student = snapshot.value;
                      student['key'] = snapshot.key;
                      return getStudentCase(student: student);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getStudentCase({Map student}){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 3,horizontal: 8),
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Student ID: " +student['key'] + "\nSubmit Case Study",
                  fontSize: 19,
                ),
                CustomText(text: "Date : "+student['date'],)
              ],
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: student['graded'] == "true" ? Colors.blue : Colors.red,
                borderRadius: BorderRadius.circular(30)
              ),
              child: CustomText(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                text: student['graded'] == "true" ? "Graded" : "Not Graded",
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Padding(
// padding: const EdgeInsets.all(20),
// child: CustomText(
// text: "Grade Summary",
// fontSize: 20,
// fontWeight: FontWeight.bold,
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// child: Container(
// height: 2,
// color: Colors.grey,
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 10),
// child: Container(
// height: MediaQuery.of(context).size.height * .66,
// child: ListView.builder(
// itemCount: caseStudy.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.all(8.0),
// child: GestureDetector(
// onTap: () {
// // Navigator.push(context, MaterialPageRoute(
// //     builder: (context) => InstructorShowReport(
// //       caseStudy: caseStudy[index],
// //       percentage: degree[index],
// //     )));
//
// openAlertBox(index);
// },
// child: Container(
// height: 60,
// color: Colors.grey.shade200,
// child: Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: 15),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// CustomText(
// text: caseStudy[index],
// fontSize: 20,
// ),
// Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// CustomText(
// text: "Average",
// color: Colors.grey,
// ),
// CustomText(
// text: "${degree[index] * 10} " + "/ 10",
// color: Colors.grey,
// ),
// ],
// )
// ],
// ),
// ),
// ),
// ),
// );
// }),
// ),
// )
// ],
// openAlertBox(int index) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Container(
//             height: MediaQuery.of(context).size.height * .52,
//             width: 300,
//             child: ListView(
//               children: [
//                 CustomText(
//                   alignment: Alignment.center,
//                   text: caseStudy[index],
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   child: CircularPercentIndicator(
//                     diameter: 140,
//                     backgroundColor: Colors.deepPurple,
//                     lineWidth: 10,
//                     percent: degree[index],
//                     animationDuration: 1000,
//                     center: new Icon(
//                       Icons.person_pin,
//                       size: 75,
//                       color: Colors.orange,
//                     ),
//                     progressColor: Colors.yellow,
//                     animation: true,
//                     backgroundWidth: 20,
//                   ),
//                 ),
//                 CustomText(
//                   alignment: Alignment.center,
//                   text: "Average : ${degree[index] * 10} / 10",
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: LinearPercentIndicator(
//                     width: double
//                         .infinity, //200, //MediaQuery.of(context).size.width *.65,
//                     animation: true,
//                     lineHeight: 50.0,
//                     animationDuration: 1000,
//                     percent: degree[index],
//                     center: CustomText(
//                       text: "${degree[index] * 100}%",
//                       fontSize: 20,
//                     ),
//                     linearStrokeCap: LinearStrokeCap.roundAll,
//                     progressColor: Colors.yellow,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 5),
//                   child: Container(
//                       width: double.infinity, //100,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color: Colors.blue),
//                       child: TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: CustomText(
//                             text: "Ok",
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ))),
//                 )
//               ],
//             ),
//           ),
//         );
//       });
// }
