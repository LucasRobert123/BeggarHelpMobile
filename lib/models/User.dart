class User {
  String id, name, phone, email, password, district, num, city, uf;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.district,
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
      'num': num,
      'city': city,
      'uf': uf,
    };
  }

  User.fromFirestore(Map<String, dynamic> firestoreDocument)
      : id = firestoreDocument['id'],
        name = firestoreDocument['name'],
        phone = firestoreDocument['phone'],
        email = firestoreDocument['email'],
        password = firestoreDocument['password'],
        district = firestoreDocument['district'],
        num = firestoreDocument['num'],
        city = firestoreDocument['city'],
        uf = firestoreDocument['uf'];
}
