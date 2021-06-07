import 'package:beggarhelp/models/User.dart';

class Donor extends User {
  String cpf;

  Donor({
    id,
    name,
    phone,
    email,
    password,
    district,
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
