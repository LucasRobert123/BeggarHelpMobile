import 'package:beggarhelp/components/Button/index.dart';
import 'package:beggarhelp/components/Input/index.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool stayConnected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Image(image: AssetImage('lib/assets/images/logo.png')),
            ),
            Input(
              text: 'E-mail',
            ),
            Input(
              text: 'Senha',
            ),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Color(0xFF31CF2B),
                      value: stayConnected,
                      onChanged: (value) {
                        setState(() {
                          stayConnected = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      'Manter-se conectado',
                      style: TextStyle(
                        color: Color(0xFF31CF2B),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Button(
              width: MediaQuery.of(context).size.width,
              heigth: 50,
              widget: Text(
                'LOGAR',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              onPress: () {
                Navigator.pushNamed(context, '/company');
              },
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Não tem conta?',
                    style: TextStyle(
                      color: Color(0xFF31CF2B),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(
                          color: Color(0xFF31CF2B),
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
