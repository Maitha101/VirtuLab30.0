import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/change_password.dart';
import 'package:virtulab/functions/database.dart';
import '../functions/auth.dart';
import 'adminNavBar.dart';

dynamic callNavBar() {
  return AdminNavBar();
}

class AdminSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminSettings();
  }
}

class _AdminSettings extends State<AdminSettings> {
  String _fullName = 'Retrieving..';
  initState() {
    super.initState();
    getFullName();
  }

  getFullName() async {
    try {
      DataSnapshot snapshot =
          await firebaseref.child('admin').child(getCurrentID()).once();
      Map admin = snapshot.value;
      setState(() {
        _fullName = admin['fname'] + ' ' + admin['lname'];
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
                  SizedBox(
                    height: 10,
                  ),
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(Icons.notifications_off),
                              ),
                              Text(
                                'Silence Notifications',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
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
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
