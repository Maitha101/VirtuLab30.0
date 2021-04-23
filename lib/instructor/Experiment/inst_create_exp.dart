import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'inst_create_exp_form.dart';

// THIS CLASS HOLDS THE CASE STUDY FORM
class CreateExperiment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text('Create Experiment'),
      ),
      body: ExperimentForm(),
    );
  }
}
