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
  TextEditingController _typeController = TextEditingController(text: "Doador");
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _cnpjController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _cityController.addListener(() {
      setState(() {
        _city = _cityController.text;
      });
    });
    _ufController.addListener(() {
      setState(() {
        _uf = _ufController.text;
      });
    });
    _typeController.addListener(() {
      setState(() {
        _type = _typeController.text;
      });
    });
    super.initState();
  }

  String _type = "Doador", _city = "Alfenas", _uf = "MG";
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> onRegister() async {
    setState(() {
      _loading = true;
    });

    if (_formKey.currentState.validate()) {
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
              uf: _uf,
              city: _city,
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
              uf: _uf,
              city: _city,
              cnpj: _cnpjController.text,
              description: _descriptionController.text);

        await FirestoreService().saveUser(user);

        Navigator.pushNamedAndRemoveUntil(context, '/welcome', (_) => false);
      }
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
          child: Form(
            key: _formKey,
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
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nome obrigatório';
                    }
                    return null;
                  },
                ),
                Input(
                  text: 'E-mail',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email obrigatório';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 - 24,
                      child: Input(
                        text: 'Telefone',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Telefone obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 - 24,
                      child: Input(
                        text: 'Senha',
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Senha obrigatória';
                          } else if (value.length < 6) {
                            return 'Senha pequena';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7 - 24,
                      child: Input(
                        text: 'Rua',
                        controller: _streetController,
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Rua obrigatória';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3 - 24,
                      child: Input(
                        text: 'Nº',
                        controller: _numController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Informe';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
                Input(
                  text: 'Bairro',
                  controller: _districtController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Bairro obrigatório';
                    }
                    return null;
                  },
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
                _type == "Doador"
                    ? Column(
                        children: [
                          Input(
                            text: 'CPF',
                            controller: _cpfController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'CPF obrigatório';
                              }
                              return null;
                            },
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Input(
                            text: 'CNPJ',
                            controller: _cnpjController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'CNPJ obrigatório';
                              }
                              return null;
                            },
                          ),
                          Input(
                            text: 'Descrição',
                            controller: _descriptionController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Descrição obrigatória';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                _loading
                    ? CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Color(0xFF31CF2B)),
                      )
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
      ),
    );
  }
}
