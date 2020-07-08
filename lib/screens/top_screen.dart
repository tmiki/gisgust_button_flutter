import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gisgustbuttonflutter/screens/main_screen.dart';

class TopScreen extends StatelessWidget {
  static const String SCREEN_ROUTE = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Gisgust Button',
                  style: TextStyle(
                    fontSize: 80.0,
                  ),
                ),
              ),
              FlatButton(
                child: Text('Start'),
                onPressed: () {
                  Navigator.pushNamed(context, MainScreen.SCREEN_ROUTE);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
