import 'package:beggarhelp/components/Button/index.dart';
import 'package:beggarhelp/components/Dropdown/index.dart';
import 'package:beggarhelp/components/Input/index.dart';
import 'package:beggarhelp/models/Company.dart';
import 'package:beggarhelp/models/Donor.dart';
import 'package:beggarhelp/models/UserData.dart';
import 'package:beggarhelp/services/auth_service.dart';
import 'package:beggarhelp/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _numController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _ufController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _cnpjController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _loading = false;

  Future<void> onRegister() async {
    setState(() {
      _loading = true;
    });

    User authUser = await AuthService.signUpUser(
      email: _emailController.text,
      senha: _passwordController.text,
    );

    if (authUser != null) {
      UserData user;

      if (_typeController.text == "Doador")
        user = Donor(
            id: authUser.uid,
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            password: _passwordController.text,
            street: _streetController.text,
            num: _numController.text,
            district: _districtController.text,
            uf: _ufController.text,
            city: _cityController.text,
            cpf: _cpfController.text);
      else
        user = Company(
            id: authUser.uid,
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            password: _passwordController.text,
            street: _streetController.text,
            num: _numController.text,
            district: _districtController.text,
            uf: _ufController.text,
            city: _cityController.text,
            cnpj: _cnpjController.text,
            description: _descriptionController.text);

      await FirestoreService().saveUser(user);

      Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false);
    }

    setState(() {
      _loading = false;
    });
  }

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
                controller: _nameController,
              ),
              Input(
                text: 'E-mail',
                controller: _emailController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 24,
                    child: Input(
                      text: 'Telefone',
                      controller: _phoneController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5 - 24,
                    child: Input(
                      text: 'Senha',
                      controller: _passwordController,
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
                      controller: _streetController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 24,
                    child: Input(
                      text: 'Nº',
                      controller: _numController,
                    ),
                  )
                ],
              ),
              Input(
                text: 'Bairro',
                controller: _districtController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3 - 24,
                    child: Dropdown(
                      text: "UF",
                      options: ["MG"],
                      controller: _ufController,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7 - 24,
                    child: Dropdown(
                      text: "Cidade",
                      options: ["Alfenas"],
                      controller: _cityController,
                    ),
                  ),
                ],
              ),
              Dropdown(
                options: ["Doador", "Instituição"],
                text: "Tipo",
                controller: _typeController,
              ),
              _typeController.text == "Doador"
                  ? Column(
                      children: [
                        Input(
                          text: 'CPF',
                          controller: _cpfController,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Input(
                          text: 'CNPJ',
                          controller: _cnpjController,
                        ),
                        Input(
                          text: 'Descrição',
                          controller: _descriptionController,
                        ),
                      ],
                    ),
              _loading
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
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
                            onPress: onRegister),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
