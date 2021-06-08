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
  factory Company.fromFirestore(Map<String, dynamic> firestoreDocument) =>
      Company(
          id: firestoreDocument['id'],
          name: firestoreDocument['name'],
          phone: firestoreDocument['phone'],
          email: firestoreDocument['email'],
          password: firestoreDocument['password'],
          district: firestoreDocument['district'],
          street: firestoreDocument['street'],
          num: firestoreDocument['num'],
          city: firestoreDocument['city'],
          uf: firestoreDocument['uf'],
          cnpj: firestoreDocument['cnpj'],
          description: firestoreDocument['description']);
}
