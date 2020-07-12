import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gisgustbuttonflutter/components/message_dialog.dart';
import 'package:gisgustbuttonflutter/constants.dart';
import 'package:gisgustbuttonflutter/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String SCREEN_PATH = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  String _email = '';
  String _password = '';

  void _signIn(BuildContext context) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: this._email.trim(), password: this._password);
      FirebaseUser user = result.user;
      print(user);
      print('isEmailVerified: "${user.isEmailVerified}"');

      if (user.isEmailVerified == true) {
        this._user = user;
        print('login succeeded.');
        Navigator.popAndPushNamed(context, MainScreen.SCREEN_PATH);
      } else {
        user.sendEmailVerification();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return MessageDialog(
                title: 'Login failed.',
                message: 'You\'ve failed to login. If you don\'t confirm the verification email yet, please check and confirm it.',
              );
            });
        this._user = null;
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(
            title: 'Login failed.',
            message: 'You\'ve failed to login. error message is "${e.toString()}"',
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Login',
                  style: TextStyle(fontSize: 40.0),
                ),
                Expanded(
                  child: Image(
                    image: AssetImage(LOGIN_IMAGE_PATH),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    this._email = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    this._password = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                FlatButton(
                  child: Text('Log In'),
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    this._signIn(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
