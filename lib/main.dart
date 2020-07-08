import 'package:flutter/material.dart';
import 'package:gisgustbuttonflutter/screens/main_screen.dart';
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
      initialRoute: TopScreen.SCREEN_ROUTE,
      routes: {
        TopScreen.SCREEN_ROUTE: (context) => TopScreen(),
        MainScreen.SCREEN_ROUTE: (context) => MainScreen(),
      },
    );
  }
}
