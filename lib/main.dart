import 'package:email_validator/email_validator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './sign_up.dart';
import 'administrator/adminNavBar.dart';
import 'forgot_password.dart';
import 'functions/auth.dart';
import 'student/stu_activity_stream.dart';
import 'student/stu_course_register.dart';
import 'instructor/inst_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(VirtuLab());
}

class VirtuLab extends StatefulWidget {
  @override
  _VirtuLabState createState() => _VirtuLabState();
}

class _VirtuLabState extends State<VirtuLab> {
  String checker;
  userCheck() async {
    SharedPreferences _perf = await SharedPreferences.getInstance();
    final user = _perf.getString('user');
    setState(() {
      checker = user;
    });
  }

  @override
  void initState() {
    super.initState();
    userCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/signup': (context) => SignUp(),
        '/student': (context) => MainStudent(), //student
        '/stu_course': (context) => StuCourseRegister(), //student course select
        '/instructor': (context) => MainInstructor(), //instructor
        '/admin': (context) => AdminNavBar(), //admin
        '/forgotPass': (context) => ForgotPassword(),
      },
      title: 'Login',
      home: checker == null ? Homepage() : loginNavigation(),
    );
  }
}

class Homepage extends StatefulWidget {
  // This widget is the root of the application.
  State<StatefulWidget> createState() {
    return _Homepage();
  }
}

class _Homepage extends State<Homepage> {
  void initState() {
    super.initState();
  }

  _validateEmail(String email) {
    if (email.isEmpty) {
      return '* Required';
    }

    //valid email
    bool _valid = EmailValidator.validate(email);
    if (_valid == false) {
      return 'Invalid Email';
    }

    return null;
  }

  _validatePass(String pass) {
    if (pass.isEmpty) {
      return '* Required';
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

  //these take user input from TextFormField
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //test on this line
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VirtuLab'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          //color: Colors.grey[300],
          width: double
              .infinity, //to make the contents center ((be as big as the parent allows))
          height: double.infinity,
          padding: EdgeInsets.all(20),
          child: Form(
            key: _loginForm,
            child: ListView(children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/logo.png',
                  // width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                  semanticLabel: 'VirtuLab Logo', //image description
                ), // written in pubspec.yaml

                SizedBox(
                  height: 20,
                ), //space between widgets

                Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),

                SizedBox(
                  height: 20,
                ),
                //...........................................Email............................................
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _emailController,
                    maxLines: 1,
                    minLines: 1,
                    validator: (value) => _validateEmail(value),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Email'),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                // .........................................Password........................................
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    controller: _passController,
                    maxLines: 1,
                    minLines: 1,
                    validator: (value) => _validatePass(value),
                    //onChanged: , //when user leaves this textfield
                    //onFieldSubmitted: , //when user presses submit button
                    obscureText: _obscurePass,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotPass');
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () => {
                            if (_loginForm.currentState.validate())
                              {
                                userLogin(_emailController.text,
                                    _passController.text, context)
                              }
                          }, //login function

                      child: Text('Login')),
                ),

                SizedBox(
                  height: 20,
                ),

                Text(
                  'Don\'t have an account?',
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 100,
                  child: TextButton(
                    onPressed: () => Navigator.pushNamed(context,
                        '/signup'), //defined in MaterialApp (routes: {}) at the top

                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
