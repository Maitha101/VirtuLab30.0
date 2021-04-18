import 'package:flutter/material.dart';
import 'package:virtulab/administrator/support_widgets/new_support.dart';
import 'package:virtulab/administrator/support_widgets/solved_support.dart';

class AdminSupport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminSupport();
  }
}

class _AdminSupport extends State<AdminSupport> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,//3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Text('New')),//icon: Icon(Icons.)),
              // Tab(child: Text('Opened')), //eehhh??
              Tab(child: Text('Solved')),
              
            ],
            ),
          centerTitle: true,
          title: Text('Technical Support'),
          backgroundColor: Colors.deepPurple,
        ),
        body: 
        // Center(child: Text('tech support'),),
        TabBarView(children: [
          Tab( child: NewTSMessage()),
          // Tab( child: Text('opened .. might delete this tab')),
          Tab( child: SolvedTSMessage()),
        ],),
      ),
    );
  }
}


