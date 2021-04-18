import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator_nullsafe/circle/circular_percent_indicator.dart';
import 'package:percent_indicator_nullsafe/linear/linear_percent_indicator.dart';
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
  List caseStudy = [
    "Case Study 1",
    "Case Study 2",
    "Case Study 3",
    "Case Study 4",
    "Case Study 5",
    "Case Study 6",
    "Case Study 7",
  ];

  List degree = [.75, .6, .9, .5, .8, .3, .4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Report Summary'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomText(
                text: "Grade Summary",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                height: 2,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * .66,
                child: ListView.builder(
                    itemCount: caseStudy.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //     builder: (context) => InstructorShowReport(
                            //       caseStudy: caseStudy[index],
                            //       percentage: degree[index],
                            //     )));

                            openAlertBox(index);
                          },
                          child: Container(
                            height: 60,
                            color: Colors.grey.shade200,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: caseStudy[index],
                                    fontSize: 20,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        text: "Average",
                                        color: Colors.grey,
                                      ),
                                      CustomText(
                                        text: "${degree[index] * 10} " + "/ 10",
                                        color: Colors.grey,
                                      ),
                                    ],
                                  )
                                ],
                              ),
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

  openAlertBox(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: MediaQuery.of(context).size.height * .52,
              width: 300,
              child: ListView(
                children: [
                  CustomText(
                    alignment: Alignment.center,
                    text: caseStudy[index],
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CircularPercentIndicator(
                      diameter: 140,
                      backgroundColor: Colors.deepPurple,
                      lineWidth: 10,
                      percent: degree[index],
                      animationDuration: 1000,
                      center: new Icon(
                        Icons.person_pin,
                        size: 75,
                        color: Colors.orange,
                      ),
                      progressColor: Colors.yellow,
                      animation: true,
                      backgroundWidth: 20,
                    ),
                  ),
                  CustomText(
                    alignment: Alignment.center,
                    text: "Average : ${degree[index] * 10} / 10",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: LinearPercentIndicator(
                      width: double
                          .infinity, //200, //MediaQuery.of(context).size.width *.65,
                      animation: true,
                      lineHeight: 50.0,
                      animationDuration: 1000,
                      percent: degree[index],
                      center: CustomText(
                        text: "${degree[index] * 100}%",
                        fontSize: 20,
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: Colors.yellow,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                        width: double.infinity, //100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue),
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: CustomText(
                              text: "Ok",
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ))),
                  )
                ],
              ),
            ),
          );
        });
  }
}
