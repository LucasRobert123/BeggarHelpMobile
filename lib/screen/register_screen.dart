import 'package:beggarhelp/components/Button/index.dart';
import 'package:beggarhelp/components/Dropdown/index.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    color: Color(0xFF31CF2B),
                  ),
                ),
              ),
              Input(
                text: 'Nome',
              ),
              Input(
                text: 'E-mail',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 24,
                    child: Input(
                      text: 'Telefone',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 24,
                    child: Input(
                      text: 'Senha',
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7 - 24,
                    child: Input(
                      text: 'Rua',
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 24,
                    child: Input(
                      text: 'Nº',
                    ),
                  )
                ],
              ),
              Input(
                text: 'Bairro',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 24,
                    child: Dropdown(
                      text: "UF",
                      options: ["MG"],
                      controller: TextEditingController(),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7 - 24,
                    child: Dropdown(
                      text: "Cidade",
                      options: ["Alfenas"],
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              ),
              Dropdown(
                options: ["Option A", "Option B", "Option C"],
                text: "Tipo",
                controller: TextEditingController(),
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
                  onPress: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/welcome', (_) => false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
