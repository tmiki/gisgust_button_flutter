import 'package:flutter/material.dart';
import 'package:gisgustbuttonflutter/screens/login_screen.dart';
import 'package:gisgustbuttonflutter/screens/main_screen.dart';
import 'package:gisgustbuttonflutter/screens/register_screen.dart';
import 'package:gisgustbuttonflutter/screens/top_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gisgust Button',
      theme: ThemeData.light(),
      initialRoute: TopScreen.SCREEN_PATH,
      routes: {
        TopScreen.SCREEN_PATH: (context) => TopScreen(),
        LoginScreen.SCREEN_PATH: (context) => LoginScreen(),
        RegisterScreen.SCREEN_PATH: (context) => RegisterScreen(),
        MainScreen.SCREEN_PATH: (context) => MainScreen(),
      },
    );
  }
}
