import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'functions/database.dart';

class ForgotPassword extends StatefulWidget {
  // This widget is the root of the application.
  State<StatefulWidget> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword> {
  final _forgotPassForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  passReset(String email) {
    auth.sendPasswordResetEmail(email: email);
  }

  _emailValidator(String email) {
    if (email.isEmpty) {
      return '* Required';
    }
    bool _valid = EmailValidator.validate(email);
    if (_valid == false) {
      return 'Invalid email address';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Reset Password"),
      ),
      body: Center(
        child: Container(
          child: Form(
            key: _forgotPassForm,
            child: Padding(
              padding: EdgeInsets.all(30),
              child: ListView(
                children: [
                  Text(
                    'Recover Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Enter your email to recover your password',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) => _emailValidator(value),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_forgotPassForm.currentState.validate()) {
                            showDialog(
                          context: context,
                          builder: (cxt) => AlertDialog(
                            title: Text('Are you sure?'),
                            content: Text(
                                'An email will be sent with a link to recover password\n\nWould you like to confirm?'),
                            actions: <Widget>[
                              TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    passReset(_emailController.text);
                                    Navigator.of(cxt).pop();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Email sent successfully'),
                                        backgroundColor:
                                            Colors.deepPurple, //change?
                                      ),
                                    );
                                  }),
                                  TextButton(child: Text('Cancel'), onPressed: ()=> Navigator.of(cxt).pop()),
                            ],
                          ),
                        );
                          }
                        },
                        child: Text('Send recovery link')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
