import 'package:flutter/material.dart';
import 'admin_support.dart';
import 'admin_courses.dart';
import 'admin_accounts.dart';
import 'admin_settings.dart';
// import 'admin_main.dart'; 

class AdminNavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AdminNavBarTab(),
    );
  }
  
}

class AdminNavBarTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminNavBarTab();
  }
}

//  getIndex (int i){
//   int index = i;
//   return index;
// }

class _AdminNavBarTab extends State<AdminNavBarTab> {
  int _barIndex = 0;
  // int _barIndex = sendIndex(); // sendIndex() is from admin_main.dart
  List<Widget> _selectedBarItem = <Widget>[
    AdminSupport(), //0
    AdminAccounts(), //1
    AdminCourses(), //2
    AdminSettings(), //3
  ];

  void navBarState(int index) {
    //sets nav bar state
    setState(() {
      _barIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _selectedBarItem.elementAt(_barIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _barIndex, //property of BottomNavigationBar
        onTap: navBarState, //sets state
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.support_agent), label: 'Tech Support'), //0
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box), label: ' Accounts'), //1
          BottomNavigationBarItem(
              icon: Icon(Icons.book), label: 'Courses'), //2
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'), //3
        ],
      ),
    );
  }
}
