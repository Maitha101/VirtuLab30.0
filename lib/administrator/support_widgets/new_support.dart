import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/database.dart';

class NewTSMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewTSMessage();
  }
}

class _NewTSMessage extends State<NewTSMessage> {
  _newMessages({Map message}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Card(
        shadowColor: Colors.deepPurple,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: null, // show full message
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  title: Text(
                    message['subject'],
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  subtitle: Text(
                    'From: ' + message['senderID'],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  leading: Icon(
                    Icons.account_circle,
                  ),
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
                          SizedBox(height: 20),
                          Text(message['message']),
                          Divider(
                            thickness: 1,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text('Mark as Solved'),
                                IconButton(
                                  iconSize: 30,
                                  icon: Icon(Icons.check_box,
                                      color: Colors.lightGreen),
                                  onPressed: () {
                                    // message.keys.;
                                    firebaseref
                                        .child('tech_support')
                                        .child(message['key'])
                                        .update({'status': 'solved'});
                                  },
                                ),
                              ])
                        ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Query statusNew;
  // exception handle
  initState() {
    super.initState();

    try {
      statusNew = firebaseref
          .child('tech_support')
          .orderByChild('status')
          .equalTo('new');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        query: statusNew,
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
            return Center(
              child: Text('no new messages'),
            );
          } else {
            return _newMessages(message: _message);
          }
        });
  }
}
