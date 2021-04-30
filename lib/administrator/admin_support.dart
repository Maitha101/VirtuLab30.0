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
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(child: Text('New')),
              Tab(child: Text('Solved')),
              
            ],
            ),
          centerTitle: true,
          title: Text('Technical Support'),
          backgroundColor: Colors.deepPurple,
        ),
        body: 
        TabBarView(children: [
          Tab( child: NewTSMessage()),
          Tab( child: SolvedTSMessage()),
        ],),
      ),
    );
  }
}


