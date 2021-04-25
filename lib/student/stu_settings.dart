import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/change_password.dart';

import '../contact_support.dart';
import '../functions/auth.dart';
import '../functions/database.dart';
// import './studentNavBar.dart';

class StudentSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentSettings();
  }
}

class _StudentSettings extends State<StudentSettings> {
  // String _studID = currentUser();
  Query _studentInfo;
  String _fullName = 'Retrieving..';
  initState() {
    super.initState();
    // exception handel
    try{
      _studentInfo = firebaseref
          .child('student')
          .orderByChild('email')
          .equalTo(getCurrentUserEmail());
    }
    catch(e){
      print(e.toString());
    }
    getFullName();
  }

  getFullName() async {
    try{
      DataSnapshot snapshot =
      await firebaseref.child('student').child(getCurrentID()).once();
      Map student = snapshot.value;
      setState(() {
        _fullName = student['fname'] + ' ' + student['lname'];
      });
    }
    catch(e){
      print(e.toString());
    }
    
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          color: Colors.grey.shade100,
          width: double.infinity,
          // height: MediaQuery.of(context).size.height * .38,
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      // margin: EdgeInsets.all(value),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      height: 140,
                      width: 130,
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 100,
                      )
                      // Image.asset(
                      //   "assets/images/profile_pic.png",
                      //   fit: BoxFit.fill,
                      // ),
                      ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _fullName,
                          // getUserFullName()
                          //     .toString(), //profile['fname'] + ' ' + profile['lname'],//"Maitha",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        size: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        getCurrentUserEmail(), //"maitha@gmail.com",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.contact_mail_outlined,
                        size: 25,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        getCurrentID(), //"101010",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                // elevation: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ChangePassword()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(Icons.edit),
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                // elevation: 5,
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Icon(Icons.notifications_off),
                            ),
                            Text(
                              'Silence Notifications',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   width: 40,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey.shade300,
                        //       borderRadius: BorderRadius.circular(50)),
                        //   child:
                        Switch(
                            value: isSwitched,
                            activeColor: Colors.deepPurple,
                            activeTrackColor: Colors.deepPurpleAccent,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                              });
                            }),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                // elevation: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ContactSupport()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(Icons.phone_in_talk),
                        ),
                        Text(
                          'Contact Support',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                // elevation: 5,
                child: InkWell(
                  onTap: () {
                    signOut(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Icon(
                            Icons.exit_to_app,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
