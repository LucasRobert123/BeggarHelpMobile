import 'package:beggarhelp/models/UserData.dart';

class Donor extends UserData {
  String cpf;

  Donor({
    id,
    name,
    phone,
    email,
    password,
    district,
    street,
    num,
    city,
    uf,
    this.cpf,
  }) : super(
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
    return {...super.toMap(), 'cpf': cpf};
  }

  @override
  factory Donor.fromFirestore(Map<String, dynamic> firestoreDocument) => Donor(
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
      cpf: firestoreDocument['cpf']);
}
