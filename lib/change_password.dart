import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:virtulab/functions/auth.dart';
import 'package:virtulab/widgets/custom_text.dart';

import 'functions/database.dart';
// import 'package:virtulab/widgets/custom_text_from_field.dart';

class ChangePassword extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _ChangePassword();
  }
}

class _ChangePassword extends State<ChangePassword> {
  final _currentPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _changePassForm = GlobalKey<FormState>();

  resetPassword(String pass) {
    final User user = auth.currentUser;
    user.updatePassword(pass);
  }

  _validateCurrent(String pass) async {
    if (pass.isEmpty) {
      return '* Required';
      //check if same pass as logged in user
    }
    User user = auth.currentUser;
    AuthCredential creds = EmailAuthProvider.credential(
        email: getCurrentUserEmail(), password: pass);
    try {
      await user.reauthenticateWithCredential(creds);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        // return 'bad bo';
        showDialog(
          context: context,
          builder: (cxt) => AlertDialog(
            title: Text('Error'),
            content: Text('Current password is incorrect'),
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
    } catch (e) {
      return 'oops';
    }

    return null;
  }

  _validateNew(String pass) {
    bool validatePattern(String value) {
      String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      return regExp.hasMatch(value);
    }

    if (pass.isEmpty) {
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text("Change Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _changePassForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                // CustomText(
                //   fontSize: 18,
                //   text: "Current Password",
                //   fontWeight: FontWeight.w600,
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10, bottom: 30),
                //   child: TextFormField(
                //     controller: _currentPassController,
                //     validator: (value) => _validateCurrent(value),
                //     obscureText: _obscurePass,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: "Current password",
                //       suffixIcon: IconButton(
                //         onPressed: _toggle,
                //         icon: Icon(_obscurePass
                //             ? Icons.visibility_off
                //             : Icons.visibility),
                //       ),
                //     ),
                //     // onChange: (v) {},
                //   ),
                // ),
                CustomText(
                  fontSize: 18,
                  text: "New Password",
                  fontWeight: FontWeight.w600,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: TextFormField(
                      controller: _newPassController,
                      validator: (value) => _validateNew(value),
                      obscureText: _obscurePass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "New password",
                        suffixIcon: IconButton(
                          onPressed: _toggle,
                          icon: Icon(_obscurePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      )

                      // onChange: (v) {},
                      ),
                ),
                CustomText(
                  fontSize: 18,
                  text: "Confirm New Password",
                  fontWeight: FontWeight.w600,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 30),
                  child: TextFormField(
                      validator: (value) {
                        if (_newPassController.text != value) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      obscureText: _obscurePass,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm new password",
                        suffixIcon: IconButton(
                          onPressed: _toggle,
                          icon: Icon(_obscurePass
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      )
                      // onChange: (v) {},
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        15,
                      )),
                  height: 60,
                  child: TextButton(
                    onPressed: () {
                      if (_changePassForm.currentState.validate()) {
                        showDialog(
                          context: context,
                          builder: (cxt) => AlertDialog(
                            title: Text('Confirm'),
                            content: Text(
                                'Are you sure you want to change your password?'),
                            actions: <Widget>[
                              TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    resetPassword(_newPassController.text);
                                    Navigator.of(cxt).pop();
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Password changed successfully'),
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
                    child: CustomText(
                      fontSize: 18,
                      text: "Update Password",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
