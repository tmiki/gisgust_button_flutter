import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({@required this.title, @required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: EdgeInsets.only(left: 16.0, top: 12.0, right: 16.0, bottom: 0.0),
      title: Text(title),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      children: <Widget>[
        Text(message),
      ],
    );
  }
}
