import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/change_password.dart';
import 'package:virtulab/contact_support.dart';
import 'package:virtulab/functions/database.dart';
import '../functions/auth.dart';

class InstSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InstSettings();
  }
}

class _InstSettings extends State<InstSettings> {
  String _fullName = 'Retrieving..';
  initState() {
    super.initState();

    getFullName();
  }

  // exception handel
  getFullName() async {
    try {
      DataSnapshot snapshot =
          await firebaseref.child('instructor').child(getCurrentID()).once();
      Map inst = snapshot.value;
      setState(() {
        _fullName = inst['fname'] + ' ' + inst['lname'];
      });
    } catch (e) {
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
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)),
                      height: 140,
                      width: 130,
                      child: Icon(
                        Icons.account_circle_sharp,
                        size: 100,
                      )),
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
                        getCurrentUserEmail(),
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
                        getCurrentID(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.deepPurple,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ChangePassword()),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.deepPurple,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Icon(Icons.notifications_off),
                            ),
                            Text(
                              'Silence Notifications',
                              style: TextStyle(fontSize: 18),
                            ),
                          ]),
                          Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.deepPurple,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ContactSupport()),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.deepPurple,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
