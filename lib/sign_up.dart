import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:virtulab/functions/database.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';

import 'functions/auth.dart';

class SignUp extends StatefulWidget {
  // This widget is the root of the application.
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}

class _SignUp extends State<SignUp> {
  //...................................... Controllers ..........................................

  final _idController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _signupForm = GlobalKey<FormState>();

  //...................................... Validate ID ..........................................
  _validateID(String id) {
    //id exists?
    // firebaseref.child('student').equalTo(id).once().then((snap) {
    //   print(snap);
    //   if (snap != null) {
    //     return 'User already exists';
    //   }
    // });

    //empty
    if (id.isEmpty) {
      return '* Required';
    }
    //length
    if (id.length != 10 && id.length != 6 && id.length !=4) {
      return 'Invalid ID';
    }

    //pattern (numbers) .. inputFormatters

    return null;
  }
//...................................... Validate Name ..........................................

  _validateName(String name) {
    if (name.isEmpty) {
      //empty
      return '* Required';
    }
    return null;
  }

//...................................... Validate Email ..........................................

  _validateEmail(String email) {
    if (email.isEmpty) {
      //empty
      return '* Required';
    }

    RegExp studEmail = RegExp('<$_idController>/@iau.edu.sa/'); //wrong
    RegExp instEmail = RegExp('[^A-Za-z0-9_].{3,}/@iau.edu.sa/'); //wrong

    // if inst email
    // if (_idController.toString().length == 6 && !instEmail.hasMatch(email)) {
    //   return 'not inst';
    // }

    //if stud email
    // if (_idController.toString().length ==10 && !studEmail.hasMatch(email)){
    //   return 'not stud';
    // }

    //valid email
    bool _valid = EmailValidator.validate(email);
    if (_valid == false) {
      return 'Invalid Email';
    }
    return null;
  }
//...................................... Validate Password ..........................................

  _validatePass(String pass) {
    bool validatePattern(String value) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      return regExp.hasMatch(value);
    }

    if (pass.isEmpty) {
      //empty
      return '* Required';
    }

    if (pass.length < 8) {
      return 'Minimum 8 characters';
    }

    if (validatePattern(pass) == false) {
      return 'Must contain:' +
          '\nAt least one upper case letter' +
          '\nAt least one lower case letter' +
          '\nAt least one digit';
    }

    return null;
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: Text('OOPS'),
        content: Text('message'),
        actions: <Widget>[
          TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(cxt).pop();
              }),
        ],
      ),
    );
  }

  bool _obscurePass = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscurePass = !_obscurePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // title: 'Sign Up',
      // home: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VirtuLab'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        width: double
            .infinity, //to make the contents center ((be as big as the parent allows))
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _signupForm,
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Sign Up',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              SizedBox(
                height: 20,
              ),
              //................................ID........................................
              Container(
                width: 275,
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  validator: (value) => _validateID(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  // keyboardType: TextInputType.number,
                  controller: _idController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Academic ID'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //................................First Name........................................
              Container(
                width: 275,
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  validator: (value) => _validateName(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  controller: _fnameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'First Name'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //................................Last Name........................................
              Container(
                width: 275,
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  validator: (value) => _validateName(value),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                  ],
                  controller: _lnameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Last Name'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //................................Email........................................
              Container(
                width: 275,
                child: TextFormField(
                  maxLines: 1,
                  minLines: 1,
                  validator: (value) => _validateEmail(value),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Academic Email'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //................................Password........................................
              Container(
                width: 275,
                child: TextFormField(
                  //onChanged: , //when user leaves this textfield
                  //onFieldSubmitted: , //when user presses submit button
                  maxLines: 1,
                  minLines: 1,
                  validator: (value) => _validatePass(value),
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                  // ],
                  obscureText: _obscurePass,
                  controller: _passController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(_obscurePass
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //................................Confirm Password........................................
              Container(
                width: 275,
                child: TextFormField(
                  //onChanged: , //when user leaves this textfield
                  //onFieldSubmitted: , //when user presses submit button
                  maxLines: 1,
                  minLines: 1,
                  validator: (value) {
                    //=> _validateConfirmPass(value),
                    if (value != _passController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    suffixIcon: IconButton(
                      onPressed: _toggle,
                      icon: Icon(_obscurePass
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                width: 275,
                child: FlutterPasswordStrength(
                  password: _passController.text,

                  // strengthColors: 0.0 ~ 0.24 : red, 0.25~0.49 : yellow, 0.50~0.74 : blue, 0.75 ~1.0 : green,
                  // duration: milliseconds: 1,
                  strengthCallback: (strength) {
                    debugPrint(strength.toString());
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //................................Signup Button........................................
              Container(
                width: 100,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      if (_signupForm.currentState.validate()) {
                        // try {
                        userSignup(
                          _idController.text,
                          _fnameController.text,
                          _lnameController.text,
                          _emailController.text,
                          _passController.text,
                          context,
                        );
                        
                        // } on HttpException catch (error) {
                        //   var errorMessage = 'Sign up Failed';
                        //   if (error.message.contains('EMAIL_EXISTS')){
                        //     errorMessage = 'This email is already in use';
                        //   }
                        //   _showError(errorMessage);
                        // } catch (error) {
                        //   var errorMessage = 'An error occurred. Try again later';
                        //   _showError(errorMessage);
                        // }
                      }
                    },
                    child: Text('Sign Up')),
              ),

              SizedBox(
                height: 20,
              ),
              //................................login........................................
              Text(
                'Already have an account?',
                textAlign: TextAlign.center,
              ),
              Container(
                width: 100,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
            ], //listview children
          ),
        ),
      ),
    );
  }
}
