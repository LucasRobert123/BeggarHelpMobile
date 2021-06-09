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

  Future<List<Company>> getCompanies() {
    return _db.collection('companies').get().then((snaps) {
      if (snaps.docs.isNotEmpty) {
        return snaps.docs
            .map((doc) => Company.fromFirestore({"id": doc.id, ...doc.data()}))
            .toList();
      } else
        return null;
    });
  }

  Future<void> makeContact(String uid, String company) {
    return _db.collection("companies").doc(company).update({
      "donors": FieldValue.arrayUnion([uid])
    });
  }

  Future<void> removeContact(String uid, String donor) {
    return _db.collection("companies").doc(uid).update({
      "donors": FieldValue.arrayRemove([donor])
    });
  }

  Future<List<Donor>> getDonorsByCompanyUID(String company) async {
    List<String> donorsIds =
        await _db.collection("companies").doc(company).get().then((snap) {
      if (snap.exists) {
        return List.from(snap.data()["donors"]);
      } else
        return null;
    });

    if (donorsIds == null)
      return null;
    else if (donorsIds.length == 0)
      return [];
    else
      return _db
          .collection('donors')
          .where(FieldPath.documentId, whereIn: donorsIds)
          .get()
          .then((snaps) {
        if (snaps.docs.isNotEmpty) {
          return snaps.docs
              .map((doc) => Donor.fromFirestore({"id": doc.id, ...doc.data()}))
              .toList();
        } else
          return null;
      });
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
          return Donor.fromFirestore({"id": snap.id, ...snap.data()});
        } else
          return Company.fromFirestore({"id": snap.id, ...snap.data()});
      } else
        return null;
    });
  }
}
