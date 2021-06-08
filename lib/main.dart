import 'package:beggarhelp/screens/companyscreen.dart';
import 'package:beggarhelp/screens/donor_screen.dart';
import 'package:beggarhelp/screens/login_screen.dart';
import 'package:beggarhelp/screens/register_screen.dart';
import 'package:beggarhelp/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beggar Help',
      theme: ThemeData(
        fontFamily: 'Poppins',
        unselectedWidgetColor: Color(0xFF31CF2B),
      ),
      initialRoute: '/',
      routes: {
        "/": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/company": (context) => CompanyScreen(),
        "/donor": (context) => DonorScreen(),
        "/welcome": (context) => WelcomeScreen()
      },
    );
  }
}
