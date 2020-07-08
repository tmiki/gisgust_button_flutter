import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gisgustbuttonflutter/components/message_dialog.dart';
import 'package:gisgustbuttonflutter/constants.dart';

class RegisterScreen extends StatefulWidget {
  static const String SCREEN_PATH = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String _email, _password;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser(BuildContext context) async {
    try {
      final AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: this._email.trim(), password: this._password);
      authResult.user.sendEmailVerification();
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MessageDialog(
            title: 'User created successfully.',
            message: 'It seems the user "${authResult.user.email}" has created successfuly. ' +
                'A verification email has been sent to your mailbox. ' +
                'You need to check and confirm it.',
          );
        },
      );
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog(
              title: 'Creating a user has failed.',
              message: 'You\'ve failed to create a user.\nerror message is "${e.toString()}"',
            );
          });
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
                  'Register',
                  style: TextStyle(fontSize: 40.0),
                ),
                Expanded(
                  child: Image(
                    image: AssetImage(REGISTER_IMAGE_PATH),
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
                  child: Text('Register'),
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    this._registerUser(context);
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
