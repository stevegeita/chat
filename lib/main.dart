import 'package:chat/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shirtup',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primaryColor: Colors.blue, 
          accentColor: Color(0xffe9f2ed)),
      home: Home(),
    );
  }
}
