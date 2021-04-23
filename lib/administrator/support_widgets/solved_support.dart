import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';

class SolvedTSMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SolvedTSMessage();
  }
}

class _SolvedTSMessage extends State<SolvedTSMessage> {
  _solvedMessages({Map message}) {
    if (message.isEmpty) {
      return Center(child: Text('No Messages'));
    } else {
      return Card(
        // color: Colors.grey[200],
        child: InkWell(
          onTap: null, // show full message
          child: Padding(
            padding: EdgeInsets.all(10.0),
            // const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              // padding: EdgeInsets.all(10),
              // height: 120,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ExpansionTile(
                  // expandedCrossAxisAlignment: CrossAxisAlignment.center,
                  tilePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  title: Text(
                    message['subject'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        color: Colors.deepPurple),
                  ),
                  subtitle: Text(
                    'From: ' + message['senderID'],
                    style: TextStyle(color: Colors.grey),
                  ),
                  leading: Icon(
                    Icons.account_circle,
                  ), // color: Colors.deepPurple,),
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      message['date'],
                                      style: TextStyle(color: Colors.grey),
                                      textAlign: TextAlign.right,
                                    )),
                              ]),
                          Text(message['message']),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Delete'),
                                        IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              firebaseref
                                                  .child('tech_support')
                                                  .child(message['key'])
                                                  .remove();
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            'Mark as New'), //, style:TextStyle(color: Colors.lightGreen)),
                                        IconButton(
                                          // iconSize: 30,
                                          icon: Icon(Icons.logout,
                                              color: Colors.blue),
                                          onPressed: () {
                                            firebaseref
                                                .child('tech_support')
                                                .child(message['key'])
                                                .update({'status': 'new'});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ])
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  Query statusSolved;
  initState() {
    super.initState();
    // statusSolved = firebaseref.child('tech_support').child('status').equalTo('solved').orderByChild('date');
    // statusSolved = firebaseref.child('tech_support').orderByChild('date');
    statusSolved = firebaseref
        .child('tech_support')
        .orderByChild('status')
        .equalTo('solved');

    firebaseref.child('tech_support').onValue.listen((event) {
      var snapshot = event.snapshot;
      setState() {
        String value = snapshot.value['status'];
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FirebaseAnimatedList(
        query: statusSolved,
        sort: (a, b) {
          return a.value['date']
              .toString()
              .compareTo(b.value['date'].toString());
        },
        defaultChild: Center(child: CircularProgressIndicator()),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map _message = snapshot.value;
          _message['key'] = snapshot.key;
          if (_message.isEmpty) {
            return Center(child: Text('No messages'));
          } else {
            return _solvedMessages(message: _message);
          }
        });
    //   ],
    // );
  }

  _emptyQuery() {
    return Center(child: Text('No Messages'));
  }
}
