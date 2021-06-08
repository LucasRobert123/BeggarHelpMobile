import 'package:beggarhelp/models/UserData.dart';

class Company extends UserData {
  String cnpj, description;

  Company(
      {id,
      name,
      phone,
      email,
      password,
      district,
      street,
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
          street: street,
          num: num,
          city: city,
          uf: uf,
        );

  @override
  Map<String, dynamic> toMap() {
    return {...super.toMap(), 'cnpj': cnpj, 'description': description};
  }

  @override
  Company.fromFirestore(Map<String, dynamic> firestoreDocument)
      : cnpj = firestoreDocument['cnpj'],
        description = firestoreDocument['description'];
}
