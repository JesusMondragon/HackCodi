import 'package:flutter/material.dart';

RaisedButton teCobroBotton({@required String title, @required Function handler}) {
  return RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(18.0),
      side: BorderSide(color: Color(0xFF5130bb), width: 2.0)
    ),
    color: Colors.white,
    textColor: Color(0xFF5130bb),
    child: Text(title),
    onPressed: handler
  );
}