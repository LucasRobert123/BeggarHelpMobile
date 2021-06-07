import 'package:beggarhelp/models/User.dart';

class Company extends User {
  String cnpj, description;

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
      this.description})
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

  @override
  Map<String, dynamic> toMap() {
    return {'cnpj': cnpj, 'description': description};
  }

  @override
  Company.fromFirestore(Map<String, dynamic> firestoreDocument)
      : cnpj = firestoreDocument['cnpj'],
        description = firestoreDocument['description'];
}
