import 'package:beggarhelp/models/User.dart';

class Company extends User {
  String cnpj, descricao;

  Company(
      {id,
      name,
      phone,
      email,
      password,
      district,
      num,
      city,
      uf,
      this.cnpj,
      this.descricao})
      : super(
          id: id,
          name: name,
          phone: phone,
          email: email,
          password: password,
          district: district,
          num: num,
          city: city,
          uf: uf,
        );
}
