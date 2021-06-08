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
    return {'cpf': cpf};
  }

  @override
  Donor.fromFirestore(Map<String, dynamic> firestoreDocument)
      : cpf = firestoreDocument['cpf'];
}
