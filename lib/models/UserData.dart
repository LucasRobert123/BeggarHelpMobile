class UserData {
  String id, name, phone, email, password, district, street, num, city, uf;

  UserData({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.district,
    this.street,
    this.num,
    this.city,
    this.uf,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'district': district,
      'street': street,
      'num': num,
      'city': city,
      'uf': uf,
    };
  }

  UserData.fromFirestore(Map<String, dynamic> firestoreDocument)
      : id = firestoreDocument['id'],
        name = firestoreDocument['name'],
        phone = firestoreDocument['phone'],
        email = firestoreDocument['email'],
        password = firestoreDocument['password'],
        district = firestoreDocument['district'],
        street = firestoreDocument['street'],
        num = firestoreDocument['num'],
        city = firestoreDocument['city'],
        uf = firestoreDocument['uf'];
}
