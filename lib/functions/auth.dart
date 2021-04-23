import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:virtulab/administrator/adminNavBar.dart';
import 'package:virtulab/instructor/inst_course_select.dart';
import 'package:virtulab/student/stu_activity_stream.dart';

import '../main.dart';
import '../tempnav.dart';
import 'database.dart';
// ...................................................SIGN UP................................................

userSignup(String id, String fname, String lname, String email, String pass,
    context) async {
  String message;

  try {
    UserCredential _creds =
        await auth.createUserWithEmailAndPassword(email: email, password: pass);
    if (id.length == 10) {
      firebaseref.child('student').child(id).set({
        'ID': id,
        'fname': fname,
        'lname': lname,
        'email': email,
      });
    }

    if (id.length == 6) {
      firebaseref.child('instructor').child(id).set({
        'ID': id,
        'fname': fname,
        'lname': lname,
        'email': email,
      });
    }

    if (id.length == 4) {
      firebaseref.child('admin').child(id).set({
        'ID': id,
        'fname': fname,
        'lname': lname,
        'email': email,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sign Up Successful'),
        backgroundColor: Colors.deepPurple, //change?
      ),
    );
    Navigator.of(context).pop();
    User user = _creds.user;
    user.updateProfile(displayName: id);

    return user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'email-already-in-use') {
      message = 'This email is already in use';
    }
  } catch (e) {
    message = 'An error occurred, please try again later';
  }

  showDialog(
    context: context,
    builder: (cxt) => AlertDialog(
      title: Text('Message'),
      content: Text(message),
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

// Future<bool> checkIDExists(String id) async {
//   DataSnapshot snapshot;
//   if (id.length == 6) {
//     snapshot = await firebaseref
//         .child('instructor')
//         .orderByChild('ID')
//         .equalTo(id)
//         .once();
//     return snapshot.key.isEmpty;
//   } else if (id.length == 10) {
//     snapshot = await firebaseref
//         .child('student')
//         .orderByChild('ID')
//         .equalTo(id)
//         .once();
//     return snapshot.key.isEmpty;
//   } else if (id.length == 4) {
//     snapshot =
//         await firebaseref.child('admin').orderByChild('ID').equalTo(id).once();
//     return snapshot.key.isEmpty;
//   }
// }

// ...................................................LOGIN................................................
userLogin(String email, String pass, context) async {
  // Auth authUser = new Auth();
  // await authUser.authLogin(email, pass);
  String message;
  try {
    UserCredential _creds =
        await auth.signInWithEmailAndPassword(email: email, password: pass);

    User user = _creds.user;
    SharedPreferences _perf = await SharedPreferences.getInstance();
    _perf.setString("user", auth.currentUser.uid);
    var location = loginNavigation();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ( context )=> location), (route) => false);
    return user;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      message = 'User does not exist';
    } else if (e.code == 'wrong-password') {
      message = 'Invalid password';
    }
  } catch (e) {
    // print(e.toString());
    message = 'An error occurred, please try again later';
  }

  showDialog(
    context: context,
    builder: (cxt) => AlertDialog(
      title: Text('Error'),
      content: Text(message),
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

loginNavigation() {
 User user = auth.currentUser;
  String id = user.displayName;
  if (id.length == 6) {
    return InstCourseSelect();
  } else if (id.length == 10) {
    return MainStudent();
  } else if (id.length == 4) {
    return AdminNavBar();//MainAdmin();
  } else {
    return TempNaV();
  }
}
// ...................................................SIGN OUT................................................

void signOut(context) {
  

  showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Are you sure you want to Log out?'),
              actions: <Widget>[
                TextButton(
                    child: Text('Yes'),
                    onPressed: () async {
                      SharedPreferences _perf = await SharedPreferences.getInstance();
                      Navigator.of(cxt).pop(); // closes alert dialog
                      auth.signOut();
                      await _perf.remove('user');
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VirtuLab()), (route) => false);
                      // takes to previos page
                    }),
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(cxt).pop();
                    }),
              ]));
  //havent tested this
}
// ...................................................GETTERS................................................

getCurrentUID() {
  final User user = auth.currentUser;
  final uid = user.uid.toString();
  return uid;
}

getCurrentID() {
  final User user = auth.currentUser;
  final id = user.displayName;
  return id;
}

getCurrentUserEmail() {
  final User user = auth.currentUser;
  final email = user.email;
  return email;
}

getUserFullName() async {
  String userID = getCurrentID();
  String email = getCurrentUserEmail();
  String userType = getUserType(userID);
  String fullName = 'placeholder';
  Map name;
  Query q = firebaseref.child(userType).orderByChild('ID').equalTo(userID);

  await firebaseref
      .child(userType)
      .orderByChild('ID')
      .equalTo(userID)
      .once()
      .then((DataSnapshot snapshot) {
    name = snapshot.value;
    name['key'] = snapshot.key;
    print(snapshot.key);
    return name;
  });
  // name = snap.value;
  // fullName = name['fname'].toString();
  //   return fullName;
}

getUserType(String id) {
  if (id.length == 6) {
    return 'instructor';
  } else if (id.length == 10) {
    return 'student';
  } else if (id.length == 4) {
    return 'admin';
  }
}
