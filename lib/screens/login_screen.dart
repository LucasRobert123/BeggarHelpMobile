import 'package:beggarhelp/components/Button/index.dart';
import 'package:beggarhelp/components/Input/index.dart';
import 'package:beggarhelp/services/auth_service.dart';
import 'package:beggarhelp/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool stayConnected = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> signIn() async {
    if (_formkey.currentState.validate()) {
      User user = await AuthService.signInUser(
        email: _emailController.text,
        senha: _passwordController.text,
      );
      if (user != null) {
        FirestoreService().getUserType(user.uid).then((type) =>
            Navigator.pushNamedAndRemoveUntil(context, '/$type', (_) => false));
      }
    } else {
      print('Erro');
    }
  }

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
            Form(
                key: _formkey,
                child: Column(
                  children: [
                    Input(
                      controller: _emailController,
                      text: 'E-mail',
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Email obrigatório';
                        }
                        return null;
                      },
                    ),
                    Input(
                      controller: _passwordController,
                      text: 'Senha',
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Senha obrigatória';
                        }
                        return null;
                      },
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
                        signIn();
                      },
                    ),
                  ],
                )),
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
