import 'package:beggarhelp/components/Button/index.dart';
import 'package:beggarhelp/components/Input/index.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Cadastre-se",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: Color(0xFF31CF2B),
                ),
              ),
              Input(
                text: 'Nome',
              ),
              Input(
                text: 'E-mail',
              ),
              /*Container(
                color: Colors.black,
                child: Row(
                  children: [
                    Input(
                      text: 'Telefone',
                    ),
                    Input(
                      text: 'Senha',
                    ),
                  ],
                ),
              ) 
              Row(
                children: [
                  Input(
                    text: 'Rua',
                  ),
                  Input(
                    text: 'Nº',
                  ),
                ],
              ),
              Input(
                text: 'Bairro',
              ),
              Row(
                children: [
                  Input(
                    text: 'UF',
                  ),
                  Input(
                    text: 'Cidade',
                  ),
                ],
              ),
              Button(
                width: MediaQuery.of(context).size.width,
                heigth: 50,
                widget: Text(
                  'VOLTAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              Button(
                width: MediaQuery.of(context).size.width,
                heigth: 50,
                widget: Text(
                  'CONTINUAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
