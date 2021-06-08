import 'package:beggarhelp/models/Company.dart';
import 'package:beggarhelp/models/Donor.dart';
import 'package:beggarhelp/models/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUser(UserData user) {
    String collection;
    collection = user is Company ? 'companies' : 'donors';
    return _db.collection(collection).doc(user.id).set(
          user.toMap(),
        );
  }

  Future<void> removeUser(UserData user) {
    String collection;
    collection = user is Company ? 'companies' : 'donors';
    return _db.collection(collection).doc(user.id).delete();
  }

  Stream<List<Company>> getCompanies() {
    return _db.collection('donors').snapshots().map(
          (snap) => snap.docs
              .map(
                (doc) => Company.fromFirestore(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<Donor>> getDonors() {
    return _db.collection('companies').snapshots().map(
          (snap) => snap.docs
              .map(
                (doc) => Donor.fromFirestore(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Future<String> getUserType(String uid) {
    return _db
        .collection("companies")
        .doc(uid)
        .get()
        .then((snap) => snap.exists ? "company" : "donor");
  }

  Future<UserData> getUserData(String uid, String type) {
    return _db.collection(type).doc(uid).get().then((snap) {
      if (snap.exists) {
        if (type == "donors") {
          return Donor.fromFirestore(snap.data());
        } else
          return Company.fromFirestore(snap.data());
      } else
        return null;
    });
  }
}
