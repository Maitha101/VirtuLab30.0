import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminEditAccounts extends StatelessWidget {
  final String courseKey;
  final String instID;
  AdminEditAccounts({this.courseKey,this.instID});

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
        onPressed: (){
          print(auth.currentUser.uid);
        },
        backgroundColor: Colors.amber,
        label: CustomText(text: "Add Student",color: Colors.white,),
      ),

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: CustomText(text: "Edit Accounts",color: Colors.white,fontSize: 22,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: instID,fontWeight: FontWeight.bold,color: Colors.white,),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: (){},
                        child: Column(
                          children: [
                            Icon(Icons.repeat,color: Colors.white,),
                            CustomText(text: "Change",color: Colors.white,)
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
            padding: const EdgeInsets.only(top: 5,left: 20,right: 20),
            child: Container(
              color: Colors.grey,
              height: 2,width: double.infinity,),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 25,right: 25),
            child: Container(
              height: MediaQuery.of(context).size.height * .58,
              child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: students[index],fontSize: 20,),
                              Padding(
                                padding: const EdgeInsets.only(top: 13),
                                child: GestureDetector(
                                  onTap: (){
                                    print("aa");
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.close,color: Colors.red,),
                                      CustomText(text: "Remove",color: Colors.red,fontSize: 15,
                                        fontWeight: FontWeight.w600,)
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
    );
  }
}
