import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gisgustbuttonflutter/constants.dart';
import 'package:gisgustbuttonflutter/screens/login_screen.dart';
import 'package:gisgustbuttonflutter/screens/main_screen.dart';
import 'package:gisgustbuttonflutter/screens/register_screen.dart';

class TopScreen extends StatefulWidget {
  static const String SCREEN_PATH = '/';

  @override
  _TopScreenState createState() => _TopScreenState();
}

class _TopScreenState extends State<TopScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoggedIn = false;
  FirebaseUser _user;

  void _updateAuthStatus() async {
    FirebaseUser user = await this._auth.currentUser();

    if (user == null) {
      setState(() {
        this._isLoggedIn = false;
      });
      return;
    } else {
      setState(() {
        this._user = user;
        this._isLoggedIn = true;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    this._updateAuthStatus();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Gisgust Button',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text('${this._isLoggedIn ? this._user.displayName : "You are not logged in."}'),
                ),
              ],
            ),
            Expanded(
              child: Image(
                image: AssetImage(TOP_IMAGE_PATH),
              ),
            ),
            FlatButton(
              child: Text('Start'),
              onPressed: () {
                Navigator.pushNamed(context, MainScreen.SCREEN_PATH);
              },
            ),
            FlatButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.SCREEN_PATH);
              },
            ),
            FlatButton(
              child: Text('Register'),
              onPressed: () {
                Navigator.pushNamed(context, RegisterScreen.SCREEN_PATH);
              },
            ),
          ],
        ),
      ),
    );
  }
}
