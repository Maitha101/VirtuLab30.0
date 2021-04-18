import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inst_step_form.dart';

class ExperimentForm extends StatefulWidget {
  @override
  _ExperimentFormState createState() => _ExperimentFormState();
}

class _ExperimentFormState extends State<ExperimentForm> {
  TextEditingController titleController;
  Query dbq;
  final _formkey = GlobalKey<FormState>();
  final dbRef = FirebaseDatabase.instance.reference().child("experiment");
  void initState() {
    super.initState();
    dbq = FirebaseDatabase.instance.reference().child('experiment');
    titleController = TextEditingController();
  }

  @override
// EXPERIMENT FORM -- START --
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formkey,
        child: ListView(
          children: <Widget>[
            Text(
              'Please Enter Experiment Title:',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.deepPurple),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              child: TextFormField(
                validator: (v) => v.isEmpty ? "*Required" : null,
                controller: titleController,
                decoration: InputDecoration(),
              ),
            ),
            Divider(),
            SizedBox(height: 15),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        String key = dbRef.push().key;
                        dbRef.child(key).set({'title': titleController.text});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExperimentStepForm(
                                      snapshotKey: key,
                                    )));
                      }
                    },
                    child: Text('Next'),
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
