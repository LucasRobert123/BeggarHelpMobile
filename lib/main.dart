import 'package:beggarhelp/pages/Login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        unselectedWidgetColor: Color(0xFF31CF2B),
      ),
      initialRoute: '/',
      routes: {"/": (context) => Login()},
    );
  }
}
