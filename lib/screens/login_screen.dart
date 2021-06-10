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
  bool isLoading = false;

  alert(msg) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Atenção'),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () => {Navigator.pop(context)},
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> signIn() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (_formkey.currentState.validate()) {
        User user = await AuthService.signInUser(
          email: _emailController.text,
          senha: _passwordController.text,
        );
        if (user != null) {
          FirestoreService().getUserType(user.uid).then((type) =>
              Navigator.pushNamedAndRemoveUntil(
                  context, '/$type', (_) => false));
        }
      }
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = true;
      });
      var msg = '';
      if (e.code == 'user-not-found') {
        msg = 'Usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        msg = "Senha incorreta";
      } else {
        msg = "Ouve um erro inesperado, tente novamente";
      }
      alert(msg);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                        keyboardType: TextInputType.emailAddress,
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
                          } else if (value.length < 6) {
                            return 'Senha deve ter no mínimo 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 8, bottom: 8),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       SizedBox(
                      //         width: 24,
                      //         height: 24,
                      //         child: Checkbox(
                      //           checkColor: Colors.white,
                      //           activeColor: Color(0xFF31CF2B),
                      //           value: stayConnected,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               stayConnected = value;
                      //             });
                      //           },
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(left: 8),
                      //         child: Text(
                      //           'Manter-se conectado',
                      //           style: TextStyle(
                      //             color: Color(0xFF31CF2B),
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Button(
                        width: MediaQuery.of(context).size.width,
                        heigth: 50,
                        widget: Center(
                          child: !isLoading
                              ? Text(
                                  'LOGAR',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                )
                              : SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
